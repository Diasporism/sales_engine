require 'merchant'
require 'bigdecimal'

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

  def self.gather_invoice_items_from_successful_transactions(successful_transactions)
    invoice_items = []
    successful_transactions.each do |transaction|
      if InvoiceItem.find_by_invoice_id(transaction.invoice_id) == nil
      else
      invoice_items << InvoiceItem.find_by_invoice_id(transaction.invoice_id)
      end
    end
    sum_invoice_items_for_each_invoice(invoice_items)
  end

  def self.sum_invoice_items_for_each_invoice(invoice_items)
    invoice_totals = {}
    invoice_items.each do |invoice_item|
      value = (invoice_item.quantity * invoice_item.unit_price)
      value = BigDecimal.new(value)
      key = invoice_item.invoice_id

      if value && !invoice_totals[key]
        invoice_totals[key] = value
      else
        invoice_totals[key] += value
      end
    end
    Merchant.sum_invoice_revenue_by_merchant_id(invoice_totals)
  end
end