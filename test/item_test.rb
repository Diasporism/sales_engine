require './test/support'
module SalesEngine
  class ItemTest < MiniTest::Unit::TestCase
    def setup
      contents = CSV.open './test/test_data/items_sample.csv', headers: true, header_converters: :symbol
      @items = Item.build_item(contents)
    end

    def teardown
      Item.clear
    end

    def test_it_builds_items
      assert_equal 10, @items
    end

    def test_items_have_correct_state
      data = {:id => '1', :name => 'Bob', 
              :description => 'description', :unit_price => '2',
              :merchant_id => '3', :created_at => '2012-03-27 14:53:59 UTC', 
              :updated_at => '2012-03-27 14:53:59 UTC'}

      item = Item.new(data)
      assert_equal 1, item.id
      assert_equal 'Bob', item.name
      assert_equal 'description', item.description
      assert_equal 0.02, item.unit_price
      assert_equal 3, item.merchant_id
      assert_equal '2012-03-27 14:53:59 UTC', item.created_at
      assert_equal '2012-03-27 14:53:59 UTC', item.updated_at
    end

    def test_it_returns_random_item
      contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol
      Item.build_item(contents)

      item_one = Item.random
      item_two = Item.random
      item_three = Item.random
      item_four = Item.random
      assert item_one != nil
      assert item_two != nil
      assert item_three != nil
      assert item_one != item_two || item_one != item_three || item_one != item_four
    end

    ############################ ID

    def test_it_finds_by_id
      item = Item.find_by_id(8)
      assert item != nil
      assert item.id == 8
    end

    def test_it_finds_all_by_id
      items = Item.find_all_by_id(8)
      assert items.count == 1
      assert items.each { |item| item.id == 8 }
    end

    ############################ Name

    def test_it_finds_by_name
      item = Item.find_by_name('Item Qui Esse')
      assert item != nil
      assert_equal item.name, 'Item Qui Esse'
    end

    def test_it_finds_all_by_name
      items = Item.find_all_by_name('Item Qui Esse')
      assert items.count == 2
      assert items.each { |item| item.name == 'Item Qui Esse' }
    end

    ############################ Description

    def test_it_finds_by_description
      item = Item.find_by_description('Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.')
      assert item != nil
      assert_equal 'Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.', item.description
    end

    def test_it_finds_all_by_description
      items = Item.find_all_by_description('Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.')
      assert_equal 2, items.count
      assert items.each { |item| item.description == 'Cumque consequuntur ad. Fuga tenetur illo molestias enim aut iste. Provident quo hic aut. Aut quidem voluptates dolores. Dolorem quae ab alias tempora.' }
    end

    ############################ Unit_Price

    def test_it_finds_by_unit_price
      item = Item.find_by_unit_price(BigDecimal.new('323.01'))
      assert item != nil
      assert_equal BigDecimal.new('323.01'), item.unit_price
    end

    def test_it_finds_all_by_unit_price
      items = Item.find_all_by_unit_price(BigDecimal.new('323.01'))
      assert_equal 2, items.count
      assert items.each { |item| item.unit_price == BigDecimal.new('323.01') }
    end

    ############################ Merchant_ID

    def test_it_finds_by_merchant_id
      item = Item.find_by_merchant_id(9)
      assert item != nil
      assert_equal 9, item.merchant_id
    end

    def test_it_finds_all_by_merchant_id
      items = Item.find_all_by_merchant_id(9)
      assert_equal 2, items.count
      assert items.each { |item| item.merchant_id == 9 }
    end

    ############################ Created_At

    def test_it_finds_by_created_at
      item = Item.find_by_created_at('2012-03-27 04:53:59 UTC')
      assert item != nil
      assert item.created_at == '2012-03-27 04:53:59 UTC'
    end

    def test_it_finds_all_by_created_at
      items = Item.find_all_by_created_at('2012-03-27 04:53:59 UTC')
      assert items.count == 2
      assert items.each { |item| item.created_at == '2012-03-27 04:53:59 UTC' }
    end

    ############################ Updated_At

    def test_it_finds_by_updated_at
      item = Item.find_by_updated_at('2012-03-27 05:53:59 UTC')
      assert item != nil
      assert item.updated_at == '2012-03-27 05:53:59 UTC'
    end

    def test_it_finds_all_by_updated_at
      items = Item.find_all_by_updated_at('2012-03-27 05:53:59 UTC')
      assert items.count == 2
      assert items.each { |customer| customer.updated_at == '2012-03-27 05:53:59 UTC' }
    end

    def test_it_finds_items_invoice_items
      contents = CSV.open './test/test_data/invoice_items_sample.csv', headers: true, header_converters: :symbol
      InvoiceItem.build_invoice_item(contents)

      item = Item.find_by_id(1)
      invoice_items = item.invoice_items
      assert_equal 3, invoice_items.count
    end

    def test_it_returns_items_merchants
      contents = CSV.open './test/test_data/merchants_sample.csv', headers: true, header_converters: :symbol
      Merchant.build_merchant(contents)

      item = Item.find_by_id(1)
      merchants = item.merchant
      assert_equal 1, merchants.id
    end

    def test_it_returns_top_items_by_revenue
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

       ranked_by_revenue = Item.most_revenue(1)
       assert_equal 'Item Dicta Autem', ranked_by_revenue[0].name
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

       items_by_quantity = Item.most_items(37)
       assert_equal 'Item Nam Magnam', items_by_quantity[1].name
       assert_equal 'Item Ut Quaerat', items_by_quantity[-1].name
    end

    def test_it_returns_total_revenue_for_item_by_best_date
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

       item = Item.find_by_name('Item Accusamus Ut')
       assert_equal Date.parse('Sat, 24 Mar 2012'), item.best_day
    end
  end
end



