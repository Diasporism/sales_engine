#require 'merchant'

module SalesEngine
  class InvoiceItem
    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @item_id = row[:item_id].to_i
      @invoice_id = row[:invoice_id].to_i
      @quantity = row[:quantity].to_i
      @unit_price = row[:unit_price].to_i
      @created_at = row[:created_at]
      @updated_at = row[:updated_at]
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

    ############################ ID

    def self.find_by_id(id)
      @@invoice_items.find { |invoice_item| invoice_item.id == id}
    end

    def self.find_all_by_id(id)
      @@invoice_items.select { |invoice_item| invoice_item.id == id}
    end

    ############################ Item_ID

    def self.find_by_item_id(id)
      @@invoice_items.find { |invoice_item| invoice_item.item_id == id}
    end

    def self.find_all_by_item_id(id)
      @@invoice_items.select { |invoice_item| invoice_item.item_id == id}
    end

      ############################ Invoice_ID

    def self.find_by_invoice_id(invoice_id)
      @@invoice_items.find { |invoice_item| invoice_item.invoice_id == invoice_id}
    end

    def self.find_all_by_invoice_id(invoice_id)
      @@invoice_items.select { |invoice_item| invoice_item.invoice_id == invoice_id}
    end

    ############################ Quanitity

    def self.find_by_quantity(number)
      @@invoice_items.find { |invoice_item| invoice_item.quantity == number}
    end

    def self.find_all_by_quantity(number)
      @@invoice_items.select { |invoice_item| invoice_item.quantity == number}
    end

    ############################ Unit Price

    def self.find_by_unit_price(price)
      @@invoice_items.find { |invoice_item| invoice_item.unit_price == price}
    end

    def self.find_all_by_unit_price(price)
      @@invoice_items.select { |invoice_item| invoice_item.unit_price == price}
    end

    ############################ Created_At

    def self.find_by_created_at(date)
      @@invoice_items.find { |invoice_item| invoice_item.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@invoice_items.select { |invoice_item| invoice_item.created_at.downcase == date.downcase}
    end

    ############################ Updated_At

    def self.find_by_updated_at(date)
      @@invoice_items.find { |invoice_item| invoice_item.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@invoice_items.select { |invoice_item| invoice_item.updated_at.downcase == date.downcase}
    end

    def invoice
      Invoice.find_by_id(invoice_id)
    end

    def item
      Item.find_by_id(item_id)
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
        #value = BigDecimal.new(value)
        key = invoice_item.invoice_id
        invoice_totals[key] += value
      end
      invoice_totals
    end

    def self.get_invoice_items_for_invoices(invoices)
      invoice_items = []
      invoices.each { |invoice| invoice_items << InvoiceItem.find_all_by_invoice_id(invoice.id) }
      invoice_items.flatten
    end

    def self.sum_revenue(invoices)
      invoice_items = get_invoice_items_for_invoices(invoices)
      revenues = []
      invoice_items.each { |invoice_item| revenues << (invoice_item.quantity * invoice_item.unit_price) }
      revenues.inject(:+)
    end

    def self.get_invoice_revenue_by_date(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)
      invoice_totals_by_date = Hash.new(0)

      invoice_items.each do |invoice_item|
        value = (invoice_item.quantity * invoice_item.unit_price)
        puts value
        #value = BigDecimal.new(value)
        key = Invoice.find_by_id(invoice_item.invoice_id).created_at
        puts key
        invoice_totals_by_date[key] += value
      end
      puts invoice_totals_by_date
      invoice_totals_by_date
    end

    def self.get_invoice_quantity(successful_transactions)
      invoice_items = get_sold_invoice_items(successful_transactions)

      invoice_totals = Hash.new(0)
      invoice_items.each do |invoice_item|
        value = invoice_item.quantity
        #value = BigDecimal.new(value)
        key = invoice_item.invoice_id
        invoice_totals[key] += value
      end
      invoice_totals
    end
  end
end
