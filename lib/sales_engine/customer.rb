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
      contents.each do |row|
        @@customer << Customer.new(row)
      end
      @@customer.count
    end

    def self.clear
      @@customer.clear
    end

    def self.random
      @@customer.sample
    end

    ############################ ID

    def self.find_by_id(id)
      @@customer.find { |customer| customer.id == id}
    end

    def self.find_all_by_id(id)
      @@customer.select { |customer| customer.id == id}
    end

    ############################ First_Name

    def self.find_by_first_name(name)
      @@customer.find { |customer| customer.first_name.downcase == name.downcase}
    end

    def self.find_all_by_first_name(name)
      @@customer.select { |customer| customer.first_name.downcase == name.downcase}
    end

    ############################ Last_Name

    def self.find_by_last_name(name)
      @@customer.find { |customer| customer.last_name.downcase == name.downcase}
    end

    def self.find_all_by_last_name(name)
      @@customer.select { |customer| customer.last_name.downcase == name.downcase}
    end

    ############################ Created_At

    def self.find_by_created_at(date)
      @@customer.find { |customer| customer.created_at.downcase == date.downcase}
    end

    def self.find_all_by_created_at(date)
      @@customer.select { |customer| customer.created_at.downcase == date.downcase}
    end

    ############################ Updated_At

    def self.find_by_updated_at(date)
      @@customer.find { |customer| customer.updated_at.downcase == date.downcase}
    end

    def self.find_all_by_updated_at(date)
      @@customer.select { |customer| customer.updated_at.downcase == date.downcase}
    end

    def invoices
      Invoice.find_all_by_customer_id(id)
    end
  end

    def self.return_customers_for_invoices(invoices)
    customers = []
    invoices.each { |invoice| customers << Customer.find_by_id(invoice.customer_id)}
    customers.flatten 
  end 

end
