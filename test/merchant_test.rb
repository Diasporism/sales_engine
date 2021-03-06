require './test/support'

module SalesEngine
  class MerchantTest < MiniTest::Unit::TestCase
    def setup
      merchants = CSV.open './test/test_data/merchants_sample.csv', headers: true, header_converters: :symbol
      @merchants = Merchant.build_merchant(merchants)
    end

    def teardown
      Merchant.clear
    end

    def test_it_builds_merchants
      assert_equal 10, @merchants
    end

    def test_merchants_have_correct_state
      data = {:id => 1, :name => 'Schroeder-Jerde', 
              :created_at => '2012-03-27 14:53:59 UTC',
              :updated_at => '2012-03-27 14:53:59 UTC'}

      merchant = Merchant.new(data)
      assert_equal 1, merchant.id
      assert_equal 'Schroeder-Jerde', merchant.name
      assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at
      assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at
    end

    def test_it_returns_random_merchant
      merchants = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol
      Merchant.build_merchant(merchants)

      merchant_one = Merchant.random
      merchant_two = Merchant.random
      assert merchant_one != merchant_two
    end


    ############################ ID

    def test_it_finds_merchants_by_id
      merchant = Merchant.find_by_id(8)
      assert merchant.id == 8
    end

    def test_it_finds_all_merchants_by_id
      merchants = Merchant.find_all_by_id(8)
      assert merchants.each { |merchant| merchant.id == 8 }
    end

    ############################ Name

    def test_it_finds_merchants_by_name
      merchant = Merchant.find_by_name('Schroeder-Jerde')
      assert_equal merchant.name, 'Schroeder-Jerde'
    end

    def test_it_finds_all_merchants_by_name
      merchants = Merchant.find_all_by_name('Schroeder-Jerde')
      assert merchants.count == 3
      assert merchants.each { |merchant| merchant.name == 'Schroeder-Jerde' }
    end

    ############################ Created_At

    def test_it_finds_merchants_by_created_at
      merchant = Merchant.find_by_created_at('2012-03-27 14:53:59 UTC')
      assert merchant.created_at == '2012-03-27 14:53:59 UTC'
    end

    def test_it_finds_all_merchants_by_created_at
      merchants = Merchant.find_all_by_created_at('2012-03-27 14:53:59 UTC')
      assert merchants.count == 3
      assert merchants.each { |merchant| merchant.created_at == '2012-03-27 14:53:59 UTC' }
    end

    ############################ Updated_At

    def test_it_finds_merchants_by_updated_at
       merchant = Merchant.find_by_updated_at('2012-03-27 14:53:59 UTC')
       assert merchant.updated_at == '2012-03-27 14:53:59 UTC'
    end

    def test_it_finds_all_merchants_by_updated_at
       merchants = Merchant.find_all_by_updated_at('2012-03-27 14:53:59 UTC')
       assert merchants.count == 3
       assert merchants.each { |merchant| merchant.updated_at == '2012-03-27 14:53:59 UTC' }
    end

    def test_it_finds_merchants_items
       contents = CSV.open './test/test_data/items_sample.csv', headers: true, header_converters: :symbol
       Item.build_item(contents)

       merchant = Merchant.find_by_name('Schroeder-Jerde')
       items = merchant.items
       assert_equal 2, items.count
    end

    def test_it_finds_merchants_invoice
       contents = CSV.open './test/test_data/invoices_sample.csv', headers: true, header_converters: :symbol
       Invoice.build_invoice(contents)

       merchant = Merchant.find_by_name('Schroeder-Jerde')
       invoices = merchant.invoices
       assert_equal 3, invoices.count
    end

    def test_it_returns_top_merchants_by_revenue
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

       ranked_by_revenue = Merchant.most_revenue(3)
       assert_equal 3, ranked_by_revenue.count
       assert_equal 'Dicki-Bednar', ranked_by_revenue[0].name
       assert_equal "Kassulke, O'Hara and Quitzon", ranked_by_revenue[1].name
       assert_equal "Okuneva, Prohaska and Rolfson", ranked_by_revenue[2].name
    end

    def test_it_returns_top_merchants_by_item
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

       ranked_by_items = Merchant.most_items(5)
       assert_equal 5, ranked_by_items.count
       assert_equal "Kassulke, O'Hara and Quitzon", ranked_by_items[0].name
       assert_equal 'Daugherty Group', ranked_by_items[4].name
    end

    def test_it_returns_revenue_by_date
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

       revenue_for_date = Merchant.revenue(Date.parse('Tue, 20 Mar 2012'))
       assert revenue_for_date != nil
    end

    def test_it_returns_total_revenue_for_single_merchant
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

       merchant = Merchant.find_by_name('Dicki-Bednar')
       assert_equal BigDecimal.new('1148393.74'), merchant.revenue

       merchant = Merchant.find_by_name('Willms and Sons')
       assert_equal BigDecimal('8373.29'), merchant.revenue(Date.parse('Fri, 09 Mar 2012'))
    end

    def test_it_returns_favorite_customers
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

       merchant = Merchant.find_by_name('Terry-Moore')
       customer = Customer.find_by_id(300)
       assert_equal customer, merchant.favorite_customer
    end

    def test_it_returns_customers_with_pending_transactions
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

       merchant_name = Merchant.find_by_name('Parisian Group')
       customer = merchant_name.customers_with_pending_invoices

       assert_equal 4, customer.count
    end
  end
end
