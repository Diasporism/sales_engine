class Merchant
#  attr_accessor :id, :name, :created_at, :updated_at

  def initialize(row)
    @id = row[:id]
    @name = row[:name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def id
    @id
  end

  def name
    @name
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

  #def self.find_by_id(id)
  #  merchants.find{ |merchant| merchant.id == id}
  #end
  #
  #def self.parse_merchants
  #  contents = CSV.open 'merchants.csv', headers: true, header_converters: :symbol
  #  build_merchant(contents)
  #end

  def self.build_merchant(contents)
    @@merchants = []
    contents.each do |row|
      @@merchants << Merchant.new(row)
    end
    @@merchants.count
  end
#
#  def self.merchants
#    @@merchants
#  end
end
#
#
#Merchant.parse_merchants
#
#Merchant.find_by_id(4)