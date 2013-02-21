module SalesEngine
  class Customer
    attr_reader :id, :first_name, :last_name, :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @first_name = row[:first_name].to_s
      @last_name = row[:last_name].to_s
      @created_at = row[:created_at].to_s
      @updated_at = row[:updated_at].to_s
    end

    def self.build_customer(contents)
      @@customer = []
      contents.each {|row| @@customer << Customer.new(row)}
      @@customer.count
    end

    def self.clear
      @@customer.clear
    end

    def self.random
      @@customer.sample
    end

    def self.find_by_id(id)
      @@customer.find {|c| c.id == id}
    end

    def self.find_all_by_id(id)
      @@customer.select {|c| c.id == id}
    end

    def self.find_by_first_name(name)
      @@customer.find {|c| c.first_name.downcase == name.downcase}
    end

    def self.find_all_by_first_name(name)
      @@customer.select {|c| c.first_name.downcase == name.downcase}
    end

    def self.find_by_last_name(name)
      @@customer.find {|c| c.last_name.downcase == name.downcase}
    end

    def self.find_all_by_last_name(name)
      @@customer.select {|c| c.last_name.downcase == name.downcase}
    end

    def self.find_by_created_at(date)
      @@customer.find {|c| c.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@customer.select {|c| c.created_at.downcase == date.downcase}
    end

    def self.find_by_updated_at(date)
      @@customer.find {|c| c.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@customer.select {|c| c.updated_at.downcase == date.downcase}
    end

    def invoices
      Invoice.find_all_by_customer_id(id)
    end

    def self.return_customers_for_invoices(invoices)
      customers = []
      invoices.each {|i| customers << Customer.find_by_id(i.customer_id)}
      customers.flatten
    end

    def transactions
      invoices = Invoice.find_all_by_customer_id(id)
      Transaction.return_transactions(invoices)
    end

    def favorite_merchant
      successful_transactions = Transaction.get_successful_transaction
      customer_merchants = Hash.new(0)
      successful_transactions.each do |transaction|
        invoice = Invoice.find_by_id(transaction.invoice_id)
        if invoice.customer_id == id
          key = invoice.merchant_id
          customer_merchants[key] += 1
        end
      end
      fav_merchants = customer_merchants.sort_by { |k,v| v }.reverse
      fav_merchant = fav_merchants[0]
      Merchant.find_by_id(fav_merchant[0])
    end
  end
end