require 'CSV'
require 'Date'
require 'bigdecimal'

require './lib/sales_engine/parser'
require './lib/sales_engine/merchant'
require './lib/sales_engine/customer'
require './lib/sales_engine/invoice'
require './lib/sales_engine/transaction'
require './lib/sales_engine/invoice_item'
require './lib/sales_engine/item'

module SalesEngine
  def self.startup
    Parser.new
  end
end
