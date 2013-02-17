class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @name = row[:name].to_s
    @description = row[:description].to_s
    @unit_price = row[:unit_price].to_i
    @merchant_id = row[:merchant_id].to_i
    @created_at = row[:created_at].to_s
    @updated_at = row[:updated_at].to_s
  end

  def self.build_item(contents)
    @@items = []
    contents.each do |row|
      @@items << Item.new(row)
    end
    @@items.count
  end

  def self.clear
    @@items.clear
  end

  def self.random
    @@items.sample
  end

  ############################ ID

  def self.find_by_id(id)
    @@items.find { |item| item.id == id}
  end

  def self.find_all_by_id(id)
    @@items.select { |item| item.id == id}
  end

  ############################ Name

  def self.find_by_name(name)
    @@items.find { |item| item.name.downcase == name.downcase}
  end

  def self.find_all_by_name(name)
    @@items.select { |item| item.name.downcase == name.downcase}
  end

  ############################ Description

  def self.find_by_description(description)
    @@items.find { |item| item.description == description}
  end

  def self.find_all_by_description(description)
    @@items.select { |item| item.description == description}
  end

  ############################ Unit_Price

  def self.find_by_unit_price(price)
    @@items.find { |item| item.unit_price == price}
  end

  def self.find_all_by_unit_price(price)
    @@items.select { |item| item.unit_price == price}
  end

  ############################ Merchant_ID

  def self.find_by_merchant_id(id)
    @@items.find { |item| item.merchant_id == id}
  end

  def self.find_all_by_merchant_id(id)
    @@items.select { |item| item.merchant_id == id}
  end

  ############################ Created_At

  def self.find_by_created_at(date)
    @@items.find { |item| item.created_at.downcase == date.downcase}
  end

  def self.find_all_by_created_at(date)
    @@items.select { |item| item.created_at.downcase == date.downcase}
  end

  ############################ Updated_At

  def self.find_by_updated_at(date)
    @@items.find { |item| item.updated_at.downcase == date.downcase}
  end

  def self.find_all_by_updated_at(date)
    @@items.select { |item| item.updated_at.downcase == date.downcase}
  end

  def invoice_items
    InvoiceItem.find_all_by_item_id(id)
  end

  def merchant
    Merchant.find_by_id(id)
  end
end