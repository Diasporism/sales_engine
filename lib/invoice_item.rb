class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @item_id = row[:item_id]
    @invoice_id = row[:invoice_id]
    @quantity = row[:quantity]
    @unit_price = row[:unit_price]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def self.build_invoice_item(contents)
    @@invoice_items = []
    contents.each do |row|
      @@invoice_items << Transaction.new(row)
    end
    @@invoice_items.count
  end
end