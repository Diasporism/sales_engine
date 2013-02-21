require './test/support'

module SalesEngine
  class InvoiceTest < MiniTest::Unit::TestCase

    def setup
      contents = CSV.open './test/test_data/invoices_sample.csv', headers: true, header_converters: :symbol
      @invoices = Invoice.build_invoice(contents)
    end

    def teardown
      Invoice.clear
    end

    def test_it_builds_invoices
      assert_equal 10, @invoices
    end

    def test_invoices_have_correct_state
      data = {:id => '1', :customer_id => '2', :merchant_id => '3', :status => 'shipped',
              :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

      invoice = Invoice.new(data)
      assert_equal 1, invoice.id
      assert_equal 2, invoice.customer_id
      assert_equal 3, invoice.merchant_id
      assert_equal 'shipped', invoice.status
      assert_equal Date.parse('2012-03-27 14:53:59 UTC'), invoice.created_at
      assert_equal Date.parse('2012-03-27 14:53:59 UTC'), invoice.updated_at
    end

    def test_it_returns_random_invoice
      invoice_one = Invoice.random
      invoice_two = Invoice.random
      invoice_three = Invoice.random
      invoice_four = Invoice.random
      assert invoice_one != nil
      assert invoice_two != nil
      assert invoice_three != nil
      assert invoice_one != invoice_two || invoice_one != invoice_three || invoice_one != invoice_four
    end

    ############################ ID

    def test_it_finds_invoices_by_id
      invoice = Invoice.find_by_id(8)
      assert invoice != nil
      assert invoice.id == 8
    end

    def test_it_finds_all_invoices_by_id
      invoices = Invoice.find_all_by_id(8)
      assert invoices.count == 1
      assert invoices.each { |invoice| invoice.id == 8 }
    end

    ############################ Customer_ID

    def test_it_finds_invoices_by_customer_id
      invoice = Invoice.find_by_customer_id(1)
      assert invoice != nil
      assert_equal invoice.customer_id, 1
    end

    def test_it_finds_all_invoices_by_customer_id
      invoices = Invoice.find_all_by_customer_id(1)
      assert invoices.count == 2
      assert invoices.each { |invoice| invoice.customer_id == 1 }
    end

    ############################ Merchant_ID

    def test_it_finds_invoices_by_merchant_id
      invoice = Invoice.find_by_merchant_id(26)
      assert invoice != nil
      assert invoice.merchant_id == 26
    end

    def test_it_finds_all_invoices_by_merchant_id
      invoices = Invoice.find_all_by_merchant_id(26)
      assert invoices.count == 2
      assert invoices.each { |invoice| invoice.merchant_id == 26 }
    end

      ############################ Status

    def test_it_finds_invoices_by_status
      invoice = Invoice.find_by_status('shipped')
      assert invoice != nil
      assert invoice.status == 'shipped'
    end

    def test_it_finds_all_invoices_by_status
      invoices = Invoice.find_all_by_status('shipped')
      assert invoices.count == 10
      assert invoices.each { |invoice| invoice.status == 'shipped' }
    end

    ############################ Created_At

    def test_it_finds_invoices_by_created_at
      invoice = Invoice.find_by_created_at('2012-03-25 09:54:09 UTC')
      assert invoice != nil
      assert invoice.created_at == Date.parse('2012-03-25 09:54:09 UTC')
    end

    def test_it_finds_all_invoices_by_created_at
      invoices = Invoice.find_all_by_created_at('2012-03-25 09:54:09 UTC')
      assert invoices.count == 2
      assert invoices.each { |invoice| invoice.created_at == '2012-03-25 09:54:09 UTC' }
    end

    ############################ Updated_At

    def test_it_finds_invoices_by_updated_at
      invoice = Invoice.find_by_updated_at('2012-03-25 09:54:09 UTC')
      assert invoice != nil
      assert invoice.updated_at == Date.parse('2012-03-25 09:54:09 UTC')
    end

    def test_it_finds_all_invoices_by_updated_at
      invoices = Invoice.find_all_by_updated_at('2012-03-25 09:54:09 UTC')
      assert invoices.count == 2
      assert invoices.each { |invoice| invoice.updated_at == Date.parse('2012-03-25 09:54:09 UTC') }
    end

    def test_it_finds_invoices_transactions
      contents = CSV.open './test/test_data/transactions_sample.csv', headers: true, header_converters: :symbol
      Transaction.build_transaction(contents)

      invoice = Invoice.find_by_id(1)
      transactions = invoice.transactions
      assert_equal 2, transactions.count
    end

    def test_it_finds_invoices_invoice_items
      contents = CSV.open './test/test_data/invoice_items_sample.csv', headers: true, header_converters: :symbol
      InvoiceItem.build_invoice_item(contents)

      invoice = Invoice.find_by_id(2)
      invoice_items = invoice.invoice_items
      assert_equal 2, invoice_items.count
    end

    def test_it_finds_invoices_items
      item_list = CSV.open './test/test_data/items_sample.csv', headers: true, header_converters: :symbol
      Item.build_item(item_list)

      invoice_item_list = CSV.open './test/test_data/invoice_items_sample.csv', headers: true, header_converters: :symbol
      InvoiceItem.build_invoice_item(invoice_item_list)

      invoice = Invoice.find_by_id(2)

      item_list = invoice.items
      assert_equal 2, item_list.count
    end

    def test_it_finds_invoices_customer
      contents = CSV.open './test/test_data/customers_sample.csv', headers: true, header_converters: :symbol
      Customer.build_customer(contents)

      invoice = Invoice.find_by_id(2)
      customer = invoice.customer
      assert customer != nil
      assert_equal 'Joey', customer.first_name
      assert_equal 'Ondricka', customer.last_name
      assert_equal '2012-03-27 14:54:09 UTC', customer.created_at
      assert_equal '2012-03-27 14:54:09 UTC', customer.updated_at
    end

    def test_it_creates_invoices_from_data
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

      customer_contents = CSV.open './data/customers.csv', headers: true, header_converters: :symbol
      Customer.build_customer(customer_contents)

      customer = Customer.find_by_id(7)
      merchant = Merchant.find_by_id(22)
      items = (1..3).map { Item.random }
      invoice = Invoice.create(customer: customer, merchant: merchant, items: items)

      assert_equal merchant.id, invoice.merchant_id
      assert_equal customer.id, invoice.customer.id
    end

    def test_it_creates_transaction_by_charging_invoice
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

      customer_contents = CSV.open './data/customers.csv', headers: true, header_converters: :symbol
      Customer.build_customer(customer_contents)

      invoice = SalesEngine::Invoice.find_by_id(100)
      prior_transaction_count = invoice.transactions.count

      invoice.charge(credit_card_number: '1111222233334444',  credit_card_expiration_date: "10/14", result: "success")

      invoice = SalesEngine::Invoice.find_by_id(invoice.id)
      assert_equal prior_transaction_count + 1, invoice.transactions.count
    end
  end
end
