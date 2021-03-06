require 'CSV'
require 'Date'
require 'bigdecimal'

require 'sales_engine/parser'
require 'sales_engine/merchant'
require 'sales_engine/customer'
require 'sales_engine/invoice'
require 'sales_engine/transaction'
require 'sales_engine/invoice_item'
require 'sales_engine/item'

module SalesEngine
  def self.startup
    Parser.new
  end
end
