#require 'merchant'

module SalesEngine
  class InvoiceItem
    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price,
    :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @item_id = row[:item_id].to_i
      @invoice_id = row[:invoice_id].to_i
      @quantity = row[:quantity].to_i
      unit_price = row[:unit_price].to_i.round(3) / 100
      @unit_price = BigDecimal.new(unit_price.to_s)
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
    end

    def item_cost
      quantity * unit_price
    end

    def self.build_invoice_item(contents)
      @@invoice_items = []
      contents.each do |row|
        @@invoice_items << InvoiceItem.new(row)
      end
      @@invoice_items.count
    end

    def self.clear
      @@invoice_items.clear
    end

    def self.random
      @@invoice_items.sample
    end

    def self.find_by_id(id)
      @@invoice_items.find {|i| i.id == id}
    end

    def self.find_all_by_id(id)
      @@invoice_items.select {|i| i.id == id}
    end

    def self.find_by_item_id(id)
      @@invoice_items.find {|i| i.item_id == id}
    end

    def self.find_all_by_item_id(id)
      @@invoice_items.select { |i| i.item_id == id}
    end

    def self.find_by_invoice_id(invoice_id)
      @@invoice_items.find {|i| i.invoice_id == invoice_id}
    end

    def self.find_all_by_invoice_id(invoice_id)
      @@invoice_items.select {|i| i.invoice_id == invoice_id}
    end

    def self.find_by_quantity(number)
      @@invoice_items.find {|i| i.quantity == number}
    end

    def self.find_all_by_quantity(number)
      @@invoice_items.select {|i| i.quantity == number}
    end

    def self.find_by_unit_price(price)
      @@invoice_items.find {|i| i.unit_price == price}
    end

    def self.find_all_by_unit_price(price)
      @@invoice_items.select {|i| i.unit_price == price}
    end

    def self.find_by_created_at(date)
      @@invoice_items.find {|i| i.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@invoice_items.select {|i| i.created_at.downcase == date.downcase}
    end

    def self.find_by_updated_at(date)
      @@invoice_items.find {|i| i.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@invoice_items.select {|i| i.updated_at.downcase == date.downcase}
    end

    def invoice
      Invoice.find_by_id(invoice_id)
    end

    def item
      Item.find_by_id(item_id)
    end

    def self.return_invoice_items_for_item(id, successful_transactions)
      items = get_sold_invoice_items(successful_transactions)
      invoice_items_and_id = []
      items.each do |invoice_item|
        if invoice_item.item_id == id
          invoice_items_and_id << invoice_item
        end
      end
      invoice_items_and_id
    end

    def self.get_quantity_by_invoice_date(invoice_items)
      invoice_totals = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = invoice_item.quantity
        invoice = Invoice.find_by_id(invoice_item.invoice_id)
        key = invoice.created_at
        invoice_totals[key] += value
      end
      invoice_totals
    end

    def self.get_sold_invoice_items(successful_transactions)
      successful_transactions.map do |transaction|
        InvoiceItem.find_all_by_invoice_id(transaction.invoice_id)
      end.flatten
    end

    def self.get_invoice_revenue(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      invoice_totals = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = (invoice_item.quantity * invoice_item.unit_price)
        value = BigDecimal.new(value)
        key = invoice_item.invoice_id
        invoice_totals[key] += value
      end
      invoice_totals
    end

    def self.get_invoice_items_for_invoices(invoices)
      items = []
      invoices.each {|i| items << InvoiceItem.find_all_by_invoice_id(i.id)}
      items.flatten
    end

    def self.sum_revenue(invoices)
      invoice_items = get_invoice_items_for_invoices(invoices)
      revenues = []
      invoice_items.each {|i| revenues << (i.quantity * i.unit_price)}
      revenues.inject(:+)
    end

    def self.get_invoice_revenue_by_date(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      invoice_totals_by_date = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = (invoice_item.quantity * invoice_item.unit_price)
        value = BigDecimal.new(value)
        key = Invoice.find_by_id(invoice_item.invoice_id).created_at
        invoice_totals_by_date[key] += value
      end
      invoice_totals_by_date
    end

    def self.get_invoice_quantity(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      invoice_totals = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = invoice_item.quantity
        value = BigDecimal.new(value)
        key = invoice_item.invoice_id
        invoice_totals[key] += value
      end
      invoice_totals
    end

    def self.get_item_revenue(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      item_totals = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = (invoice_item.quantity * invoice_item.unit_price)
        key = invoice_item.item_id
        item_totals[key] += value
      end
      item_totals
    end

    def self.get_item_quantity(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      item_quantities = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = invoice_item.quantity
        key = invoice_item.item_id
        item_quantities[key] += value
      end
      item_quantities
    end

    def self.time
      Time.now.getutc.to_s
    end

    def self.create(items, invoice_item_id)
      items_count = Hash.new(0)
      items.each do |item|
        items_count[item] += 1
      end
      items.each do |item|
        quantity = items_count.select { |k, v| k == item}.values
        quantity = quantity[0].to_i
        invoice_item_template = {:id => @@invoice_items.count + 1,
                                 :item_id => item.id,
                                 :invoice_id => invoice_item_id,
                                 :quantity => quantity,
                                 :unit_price => item.unit_price,
                                 :created_at => time,
                                 :updated_at => time}
        invoice_item = InvoiceItem.new(invoice_item_template)
        @@invoice_items << invoice_item
      end
    end
  end
end
