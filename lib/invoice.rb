class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_s
    @created_at = row[:created_at].to_s
    @updated_at = row[:updated_at].to_s
  end

  def self.build_invoice(contents)
    @@invoices = []
    contents.each do |row|
      @@invoices << Invoice.new(row)
    end
    @@invoices.count
  end

  def self.random
    @@invoices.sample
  end

  ############################ ID

  def self.find_by_id(id)
    @@invoices.find { |invoice| invoice.id == id}
  end

  def self.find_all_by_id(id)
    @@invoices.select { |invoice| invoice.id == id}
  end

  ############################ Customer_ID

  def self.find_by_customer_id(id)
    @@invoices.find { |invoice| invoice.customer_id == id}
  end

  def self.find_all_by_customer_id(id)
    @@invoices.select { |invoice| invoice.customer_id == id}
  end

  ############################ Merchant_ID

  def self.find_by_merchant_id(id)
    @@invoices.find { |invoice| invoice.merchant_id == id}
  end

  def self.find_all_by_merchant_id(id)
    @@invoices.select { |invoice| invoice.merchant_id == id}
  end

  ############################ Status

  def self.find_by_status(id)
    @@invoices.find { |invoice| invoice.status == id}
  end

  def self.find_all_by_status(id)
    @@invoices.select { |invoice| invoice.status == id}
  end

  ############################ Created_At

  def self.find_by_created_at(date)
    @@invoices.find { |invoice| invoice.created_at.downcase == date.downcase}
  end

  def self.find_all_by_created_at(date)
    @@invoices.select { |invoice| invoice.created_at.downcase == date.downcase}
  end

  ############################ Updated_At

  def self.find_by_updated_at(date)
    @@invoices.find { |invoice| invoice.updated_at.downcase == date.downcase}
  end

  def self.find_all_by_updated_at(date)
    @@invoices.select { |invoice| invoice.updated_at.downcase == date.downcase}
  end
end