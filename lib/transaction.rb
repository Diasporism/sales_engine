class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @invoice_id = row[:invoice_id].to_i
    @credit_card_number = row[:credit_card_number].to_i
    @credit_card_expiration_date = row[:credit_card_expiration_date].to_s
    @result = row[:result].to_s
    @created_at = row[:created_at].to_s
    @updated_at = row[:updated_at].to_s
  end

  def self.build_transaction(contents)
    @@transactions = []
    contents.each do |row|
      @@transactions << Transaction.new(row)
    end
    @@transactions.count
  end

  def self.random
    @@transactions.sample
  end

  ############################ ID

  def self.find_by_id(id)
    @@transactions.find { |transaction| transaction.id == id}
  end

  def self.find_all_by_id(id)
    @@transactions.select { |transaction| transaction.id == id}
  end

  ############################ Invoice_ID

  def self.find_by_invoice_id(id)
    @@transactions.find { |transaction| transaction.invoice_id == id}
  end

  def self.find_all_by_invoice_id(id)
    @@transactions.select { |transaction| transaction.invoice_id == id}
  end

  ############################ Credit_Card_Number

  def self.find_by_credit_card_number(number)
    @@transactions.find { |transaction| transaction.credit_card_number == number}
  end

  def self.find_all_by_credit_card_number(number)
    @@transactions.select { |transaction| transaction.credit_card_number == number}
  end

  ############################ Result

  def self.find_by_result(result)
    @@transactions.find { |transaction| transaction.result.downcase == result.downcase}
  end

  def self.find_all_by_result(result)
    @@transactions.select { |transaction| transaction.result.downcase == result.downcase}
  end

  ############################ Created_At

  def self.find_by_created_at(date)
    @@transactions.find { |transaction| transaction.created_at.downcase == date.downcase}
  end

  def self.find_all_by_created_at(date)
    @@transactions.select { |transaction| transaction.created_at.downcase == date.downcase}
  end

  ############################ Updated_At

  def self.find_by_updated_at(date)
    @@transactions.find { |transaction| transaction.updated_at.downcase == date.downcase}
  end

  def self.find_all_by_updated_at(date)
    @@transactions.select { |transaction| transaction.updated_at.downcase == date.downcase}
  end

  def self.transactions
    @@transactions
  end

  def invoice
    Invoice.find_by_id(invoice_id)
  end
end