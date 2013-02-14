class Transaction
  attr_reader :id, :invoice_id, :credit_card_number, :credit_card_expiration_date, :result, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @invoice_id = row[:invoice_id]
    @credit_card_number = row[:credit_card_number]
    @credit_card_expiration_date = row[:credit_card_expiration_date]
    @result = row[:result]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def self.build_transaction(contents)
    @@transaction = []
    contents.each do |row|
      @@transaction << Transaction.new(row)
    end
    @@transaction.count
  end

  def self.random
    @@merchants.sample
  end

  ############################ ID

  def self.find_by_id(id)
    @@merchants.find { |merchant| merchant.id == id}
  end

  def self.find_all_by_id(id)
    @@merchants.select { |merchant| merchant.id == id}
  end

  ############################ Name

  def self.find_by_name(name)
    @@merchants.find { |merchant| merchant.name.downcase == name.downcase}
  end

  def self.find_all_by_name(name)
    @@merchants.select { |merchant| merchant.name.downcase == name.downcase}
  end

  ############################ Created_At

  def self.find_by_created_at(date)
    @@merchants.find { |merchant| merchant.created_at.downcase == date.downcase}
  end

  def self.find_all_by_created_at(date)
    @@merchants.select { |merchant| merchant.created_at.downcase == date.downcase}
  end

  ############################ Updated_At

  def self.find_by_updated_at(date)
    @@merchants.find { |merchant| merchant.updated_at.downcase == date.downcase}
  end

  def self.find_all_by_updated_at(date)
    @@merchants.select { |merchant| merchant.updated_at.downcase == date.downcase}
  end

  def self.merchants
    @@merchants
  end
end