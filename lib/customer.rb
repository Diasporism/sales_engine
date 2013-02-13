class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at

  def initialize(row)
    @id = row[:id].to_i
    @first_name = row[:first_name]
    @last_name = row[:last_name]
    @created_at = row[:created_at]
    @updated_at = row[:updated_at]
  end

  def self.build_customer(contents)
    @@customer = []
    contents.each do |row|
      @@customer << Customer.new(row)
    end
    @@customer.count
  end

  def self.random
    @@customer.sample
  end

  def self.find_by_id(id)
    @@customer.find { |customer| customer.id == id}
  end

  def self.find_all_by_id(id)
    @@customer.select { |customer| customer.id == id}
  end
end