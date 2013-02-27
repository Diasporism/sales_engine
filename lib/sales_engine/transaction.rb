module SalesEngine
  class Transaction
    attr_reader :id, :invoice_id, :credit_card_number,
                :credit_card_expiration_date, :result,
                :created_at, :updated_at

    def initialize(row)
      @id = row[:id].to_i
      @invoice_id = row[:invoice_id].to_i
      @credit_card_number = row[:credit_card_number].to_s
      @credit_card_expiration_date = row[:credit_card_expiration_date].to_s
      @result = row[:result].to_s
      @created_at = row[:created_at].to_s
      @updated_at = row[:updated_at].to_s
    end

    def successful?
      result == "success"
    end

    def self.count
      @@transactions.count
    end

    def self.build_transaction(contents)
      @@transactions = []
      contents.each {|row| @@transactions << Transaction.new(row)}
      count
    end

    def self.clear
      @@transactions.clear
    end

    def self.random
      @@transactions.sample
    end

    def self.find_by_id(id)
      @@transactions.find {|t| t.id == id}
    end

    def self.find_all_by_id(id)
      @@transactions.select {|t| t.id == id}
    end

    def self.find_by_invoice_id(id)
      @@transactions.find {|t| t.invoice_id == id}
    end

    def self.find_all_by_invoice_id(id)
      @@transactions.select {|t| t.invoice_id == id}
    end

    def self.find_by_credit_card_number(number)
      @@transactions.find {|t| t.credit_card_number == number}
    end

    def self.find_all_by_credit_card_number(number)
      @@transactions.select {|t| t.credit_card_number == number}
    end

    def self.find_by_result(result)
      @@transactions.find {|t| t.result.downcase == result.downcase}
    end

    def self.find_all_by_result(result)
      @@transactions.select {|t| t.result.downcase == result.downcase}
    end

    def self.find_by_created_at(date)
      @@transactions.find {|t| t.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@transactions.select {|t| t.created_at.downcase == date.downcase}
    end

    def self.find_by_updated_at(date)
      @@transactions.find {|t| t.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@transactions.select {|t| t.updated_at.downcase == date.downcase}
    end

    def self.transactions
      @@transactions
    end

    def invoice
      Invoice.find_by_id(invoice_id)
    end

    def self.get_successful_transaction
      @@transactions.select {|t| t.result == 'success'}
    end

    def self.get_invoices_from_transaction(transactions)
      invoices = []
      transactions.each {|t| invoices << Invoice.find_by_id(t.invoice_id)}
      invoices
    end

    def self.get_pending_transaction
      @@transactions.select {|t| t.result == ''}
    end

    def self.charge(input, invoice_id)
      time = Time.now.getutc.to_s
      transaction_template = {:id => Transaction.count,
            :invoice_id => invoice_id,
            :credit_card_number => input[:credit_card_number],
            :credit_card_expiration_date => input[:credit_card_expiration_date],
            :result => input[:result],
            :created_at => time,
            :updated_at => time}
      transaction = Transaction.new(transaction_template)
      @@transactions << transaction
    end

    def self.return_transactions(invoices)
      transactions = []
      invoices.each {|i| transactions << find_all_by_invoice_id(i.id)}.flatten!
      transactions
    end
  end
end
