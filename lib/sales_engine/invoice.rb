module SalesEngine
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

    def merchant
      Merchant.find_by_id(merchant_id)
    end

    def customer
      Customer.find_by_id(customer_id)
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

    def self.sum_by_customer_id(invoices)
      transactions_by_customer = Hash.new(0)

      invoices.each do |invoice|
        key = invoice.customer_id
        if transactions_by_customer[key]
          transactions_by_customer[key] += 1
        else
          transactions_by_customer[key] = 1
        end
      end
      transactions_by_customer.sort_by { |k,v| v }.reverse
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

     def self.return_successful_invoices(invoices)
      successful_invoices = []
      invoices.each do |invoice|
        transactions = Transaction.find_all_by_invoice_id(invoice.id)
        if transactions.any? { |transaction| transaction.result == "success"}
            successful_invoices << invoice
        end 
      end
      successful_invoices
    end

    def self.create(input)
      time = Time.now.getutc.to_s

      invoice_template = {:id => @@invoices.count + 1,
                          :customer_id => input[:customer].id,
                          :merchant_id => input[:merchant].id,
                          :status => 'shipped',
                          :created_at => time,
                          :updated_at => time}

      invoice = Invoice.new(invoice_template)
      @@invoices << invoice
      invoice_item_id = @@invoices.count
      InvoiceItem.create(input[:items], invoice_item_id)
      invoice
    end

    def charge(input)
      invoice_id = self.id
      Transaction.charge(input, invoice_id)
    end
  end
end