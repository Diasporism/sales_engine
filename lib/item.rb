class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @name = row[:name]
    @description = row[:description]
    @unit_price = row[:unit_price]
    @merchant_id = row[:merchant_id]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def self.build_item(contents)
    @@items = []
    contents.each do |row|
      @@items << Item.new(row)
    end
    @@items.count
  end
end