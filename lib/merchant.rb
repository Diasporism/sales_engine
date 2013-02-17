require 'invoice'

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
    Item.find_all_by_merchant_id(id)
  end

  def invoices
    Invoice.find_all_by_merchant_id(id)
  end

  def self.most_revenue(rank)
    if rank == 0
      rank = 1
    end
    Transaction.get_successful_transaction
    @merchant_revenues_sorted_array[0..(rank - 1)]
  end

  def self.sum_invoice_revenue_by_merchant_id(invoice_totals)
    merchant_revenues = {}
    invoice_totals.each do |invoice_total|
      value = invoice_total[1]
      invoice = Invoice.find_by_id(invoice_total[0])
      key = invoice.merchant_id
      if value && !merchant_revenues[key]
        merchant_revenues[key] = value
      else
        merchant_revenues[key] += value
      end
    end
    merchant_revenues_array = merchant_revenues.sort
    @merchant_revenues_sorted_array = merchant_revenues_array.sort {|a,b| b[1] <=> a[1]}
  end
end