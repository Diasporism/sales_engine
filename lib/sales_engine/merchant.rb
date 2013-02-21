module SalesEngine
  class Merchant
    attr_reader :id, :name, :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @name = row[:name].to_s
      @created_at = row[:created_at].to_s
      @updated_at = row[:updated_at].to_s
    end

    def self.build_merchant(contents)
      @@merchants = []
      contents.each {|row| @@merchants << Merchant.new(row)}
      @@merchants.count
    end

    def self.clear
      @@merchants.clear
    end

    def self.random
      @@merchants.sample
    end

    def self.find_by_id(id)
      @@merchants.find {|m| m.id == id}
    end

    def self.find_all_by_id(id)
      @@merchants.select {|m| m.id == id}
    end

    def self.find_by_name(name)
      @@merchants.find {|m| m.name.downcase == name.downcase}
    end

    def self.find_all_by_name(name)
      @@merchants.select {|m| m.name.downcase == name.downcase}
    end

    def self.find_by_created_at(date)
      @@merchants.find {|m| m.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@merchants.select {|m| m.created_at.downcase == date.downcase}
    end

    def self.find_by_updated_at(date)
      @@merchants.find {|m| m.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@merchants.select {|m| m.updated_at.downcase == date.downcase}
    end

    def self.merchants
      @@merchants
    end

    def items
      Item.find_all_by_merchant_id(id)
    end

    def invoices
      Invoice.find_all_by_merchant_id(id)
    end

    def self.rank(array, rank)
      array[0..(rank - 1)].map {|item| Merchant.find_by_id(item[0])}
    end

    def self.most_revenue(rank)
      rank = 1 if rank == 0
      most_revenue = Merchant.sum_value_by_merchant_id(InvoiceItem.get_invoice_revenue(Transaction.get_successful_transaction))
      rank(most_revenue, rank)
    end

    def self.most_items(rank)
      rank = 1 if rank == 0
      most_items = Merchant.sum_value_by_merchant_id(InvoiceItem.get_invoice_quantity(Transaction.get_successful_transaction))
      rank(most_items, rank)
    end

    def self.revenue(date)
      results = Invoice.sum_revenue_by_date(InvoiceItem.get_invoice_revenue(Transaction.get_successful_transaction))
      results = results.select { |item| item[0] == date }.flatten
      results[1]
    end

    def revenue(date=nil)
      if date == nil
        InvoiceItem.sum_revenue(Invoice.get_invoices_by_merchant(id, Transaction.get_invoices_from_transaction(Transaction.get_successful_transaction)))
      else
        InvoiceItem.sum_revenue(Invoice.get_invoices_by_date(date, Invoice.get_invoices_by_merchant(id, Transaction.get_invoices_from_transaction(Transaction.get_successful_transaction))))
      end
    end

    def favorite_customer
      ranked_invoices = Invoice.sum_by_customer_id(Invoice.get_invoices_by_merchant(id, Transaction.get_invoices_from_transaction(Transaction.get_successful_transaction)))
      favorite_customer_id = ranked_invoices[0]
      Customer.find_by_id(favorite_customer_id[0])
    end

    def self.sum_value_by_merchant_id(invoice_totals)
      merchant_revenues = Hash.new(0)
      invoice_totals.each_pair do |k, v|
        invoice = Invoice.find_by_id(k)
        key = invoice.merchant_id
        merchant_revenues[key] += v
      end
      merchant_revenues.sort_by { |k,v| v }.reverse
    end

    def self.sum_value_by_merchant_id_for_date(invoice_totals)
      merchant_revenues = Hash.new(0)
      invoice_totals.each_pair do |k, v|
        invoice = Invoice.find_by_id(k)
        key = invoice.merchant_id
        merchant_revenues[key] += v
      end
      merchant_revenues.sort_by { |k,v| v }.reverse
    end

    def customers_with_pending_invoices
      Customer.return_customers_for_invoices(Invoice.find_transactions_for_pending_invoices(Invoice.find_all_by_merchant_id(id)))
    end
  end
end
