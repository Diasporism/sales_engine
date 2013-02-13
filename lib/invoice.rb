class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @customer_id = row[:customer_id]
    @merchant_id = row[:merchant_id]
    @status = row[:status]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def self.build_invoice(contents)
    @@invoices = []
    contents.each do |row|
      @@invoices << Invoice.new(row)
    end
    @@invoices.count
  end
end