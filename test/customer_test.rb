require './test/support'

module SalesEngine
  class CustomerTest < MiniTest::Unit::TestCase
    def setup
      contents = CSV.open './test/test_data/customers_sample.csv', headers: true, header_converters: :symbol
      @customers = Customer.build_customer(contents)
    end

    def teardown
      Customer.clear
    end

    def test_it_builds_customers
      assert_equal 10, @customers
    end

    def test_customers_have_correct_state
      data = {:id => '1', :first_name => 'Thomas', :last_name => 'Jefferson',
              :created_at => '2012-03-27 14:53:59 UTC', 
              :updated_at => '2012-03-27 14:53:59 UTC'}

      customer = Customer.new(data)
      assert_equal 1, customer.id
      assert_equal 'Thomas', customer.first_name
      assert_equal 'Jefferson', customer.last_name
      assert_equal '2012-03-27 14:53:59 UTC', customer.created_at
      assert_equal '2012-03-27 14:53:59 UTC', customer.updated_at
    end

    def test_it_returns_random_customer
      customer_one = Customer.random
      customer_two = Customer.random
      customer_three = Customer.random
      customer_four = Customer.random
      assert customer_one != nil
      assert customer_two != nil
      assert customer_three != nil
      assert customer_one != customer_two || customer_one != customer_three || customer_one != customer_four
    end

    ############################ ID

    def test_it_finds_by_id
      customer = Customer.find_by_id(8)
      assert customer != nil
      assert customer.id == 8
    end

    def test_it_finds_all_by_id
      customers = Customer.find_all_by_id(8)
      assert customers.count == 1
      assert customers.each { |customer| customer.id == 8 }
    end

    ############################ First_Name

    def test_it_finds_by_first_name
      customer = Customer.find_by_first_name('Joey')
      assert customer != nil
      assert_equal customer.first_name, 'Joey'
    end

    def test_it_finds_all_by_first_name
      customers = Customer.find_all_by_first_name('Joey')
      assert customers.count == 2
      assert customers.each { |customer| customer.first_name == 'Joey' }
    end

    ############################ Last_Name

    def test_it_finds_by_last_name
      customer = Customer.find_by_last_name('Toy')
      assert customer != nil
      assert customer.last_name == 'Toy'
    end

    def test_it_finds_all_by_last_name
      customers = Customer.find_all_by_last_name('Toy')
      assert customers.count == 2
      assert customers.each { |customer| customer.last_name == 'Toy' }
    end

    ############################ Created_At

    def test_it_finds_by_created_at
      customer = Customer.find_by_created_at('2012-06-27 14:54:10 UTC')
      assert customer != nil
      assert customer.created_at == '2012-06-27 14:54:10 UTC'
    end

    def test_it_finds_all_by_created_at
      customers = Customer.find_all_by_created_at('2012-06-27 14:54:10 UTC')
      assert customers.count == 2
      assert customers.each { |customer| customer.created_at == '2012-06-27 14:54:10 UTC' }
    end

    ############################ Updated_At

    def test_it_finds_by_updated_at
      customer = Customer.find_by_updated_at('2012-07-27 14:54:10 UTC')
      assert customer != nil
      assert customer.updated_at == '2012-07-27 14:54:10 UTC'
    end

    def test_it_finds_all_by_updated_at
      customers = Customer.find_all_by_updated_at('2012-07-27 14:54:10 UTC')
      assert customers.count == 2
      assert customers.each { |customer| customer.updated_at == '2012-07-27 14:54:10 UTC' }
    end

    def test_it_returns_customers_invoices
      contents = CSV.open './test/test_data/invoices_sample.csv', headers:true, header_converters: :symbol
      Invoice.build_invoice(contents)

      customer = Customer.find_by_id(1)
      invoices = customer.invoices
      assert_equal 2, invoices.count
    end

    def test_it_returns_customers_transactions

      customer_contents = CSV.open './data/customers.csv', headers: true, header_converters: :symbol
      Customer.build_customer(customer_contents)

      invoice_contents = CSV.open './data/invoices.csv', headers: true, header_converters: :symbol
      Invoice.build_invoice(invoice_contents)

      invoice_item_contents = CSV.open './data/invoice_items.csv', headers: true, header_converters: :symbol
      InvoiceItem.build_invoice_item(invoice_item_contents)

      item_contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol
      Item.build_item(item_contents)

      transaction_contents = CSV.open './data/transactions.csv', headers: true, header_converters: :symbol
      Transaction.build_transaction(transaction_contents)

      merchant_contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
      Merchant.build_merchant(merchant_contents)

      customer = Customer.find_by_id(2)
      customer_transactions = customer.transactions

      assert_equal 1, customer_transactions.count
    end
  end
end




