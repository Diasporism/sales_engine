class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_s
    @created_at = Date.parse(row[:created_at])
    @updated_at = Date.parse(row[:updated_at])
  end

  def self.build_invoice(contents)
    @@invoices = []
    contents.each do |row|
      @@invoices << Invoice.new(row)
    end
    @@invoices.count
  end

  def self.clear
    @@invoices.clear
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
    @@invoices.find { |invoice| invoice.created_at == Date.parse(date)}
  end

  def self.find_all_by_created_at(date)
    @@invoices.select { |invoice| invoice.created_at == Date.parse(date)}
  end

  ############################ Updated_At

  def self.find_by_updated_at(date)
    @@invoices.find { |invoice| invoice.updated_at == Date.parse(date)}
  end

  def self.find_all_by_updated_at(date)
    @@invoices.select { |invoice| invoice.updated_at == Date.parse(date)}
  end

  def transactions
    Transaction.find_all_by_invoice_id(id)
  end

  def invoice_items
    InvoiceItem.find_all_by_invoice_id(id)
  end

  def items
    invoice_item = InvoiceItem.find_all_by_invoice_id(id)

    item_id = []
    invoice_item.each { |item| item_id << item.item_id }

    item_list = []
    item_id.each { |id| item_list << Item.find_by_id(id) }

    item_list
  end

  def customer
    Customer.find_by_id(customer_id)
  end

  def format_dates(invoices)
    invoices.each do |invoice|
      Date.parse(invoice.created_at)
    end
  end

  def self.sum_revenue_by_date(invoice_totals)
    revenues = Hash.new(0)
    invoice_totals.each_pair do |k, v|
      invoice = Invoice.find_by_id(k)
      key = invoice.created_at
      revenues[key] += v
    end
    revenues.sort_by { |k,v| v }.reverse
  end

  def self.get_invoices_by_merchant(id, invoices)
    invoices.select { |invoice| invoice if invoice.merchant_id == id}
  end

  def self.get_invoices_by_date(date, invoices)
    invoices.select { |invoice| invoice if invoice.created_at == date}
  end

  def self.find_transactions_for_pending_invoices(invoices)
    pending_invoices = []
    invoices.each do |invoice|
      transactions = Transaction.find_all_by_invoice_id(invoice.id)
      if transactions.none? { |transaction| transaction.result == "success"}
          pending_invoices << invoice
      end 
    end
    pending_invoices
  end 


end



