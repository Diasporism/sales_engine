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
    contents.each do |row|
      @@merchants << Merchant.new(row)
    end
    Database.store(@@merchants)
    @@merchants.count
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

  def items
    name = self.name
    find_items_for_merchant(name)
  end

  def find_items_for_merchant(name)
    merchant = Merchant.find_by_name(name)
    merchant_id = merchant.id
    Item.find_all_by_merchant_id(merchant_id)
  end

  def invoices
    name = self.name
    find_invoices_for_merchant(name)
  end

  def find_invoices_for_merchant(name)
    merchant = Merchant.find_by_name(name)
    merchant_id = merchant.id
    Invoice.find_all_by_merchant_id(merchant_id)
  end

end