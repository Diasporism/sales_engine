require './test/support'

module SalesEngine
  class InvoiceItemTest < MiniTest::Unit::TestCase

    def setup
      contents = CSV.open './test/test_data/invoice_items_sample.csv', headers: true, header_converters: :symbol
      @invoice_items = InvoiceItem.build_invoice_item(contents)
    end

    def teardown
      InvoiceItem.clear
    end

    def test_it_builds_invoice_items
      assert_equal 10, @invoice_items
    end

    def test_invoice_items_have_correct_state
      data = {:id => '1', :item_id => '2', :invoice_id => '3', 
              :quantity => '4', :unit_price => '5', 
              :created_at => '2012-03-27 14:53:59 UTC', 
              :updated_at => '2012-03-27 14:53:59 UTC'}

      invoice_item = InvoiceItem.new(data)
      assert_equal 1, invoice_item.id
      assert_equal 2, invoice_item.item_id
      assert_equal 3, invoice_item.invoice_id
      assert_equal 4, invoice_item.quantity
      assert_equal BigDecimal.new('0.05'), invoice_item.unit_price
      assert_equal '2012-03-27 14:53:59 UTC', invoice_item.created_at
      assert_equal '2012-03-27 14:53:59 UTC', invoice_item.updated_at
    end

    def test_it_returns_random_invoice_items
      invoice_item_one = InvoiceItem.random
      invoice_item_two = InvoiceItem.random
      invoice_item_three = InvoiceItem.random
      invoice_item_four = InvoiceItem.random
      assert invoice_item_one != nil
      assert invoice_item_two != nil
      assert invoice_item_three != nil
      assert invoice_item_one != invoice_item_two || invoice_item_one != invoice_item_three || invoice_item_one != invoice_item_four
    end


    ############################ ID

    def test_it_finds_invoices_items_by_id
      invoice_item = InvoiceItem.find_by_id(8)
      assert invoice_item != nil
      assert invoice_item.id == 8
    end

    def test_it_finds_all_invoice_items_by_id
      invoice_items = InvoiceItem.find_all_by_id(8)
      assert invoice_items.count == 1
      assert invoice_items.each { |invoice_item| invoice_item.id == 8 }
    end

   ############################ Item_ID

    def test_it_finds_invoice_items_by_item_id
      invoice_item = InvoiceItem.find_by_item_id(1)
      assert invoice_item != nil
      assert invoice_item.item_id == 1
    end

    def test_it_finds_all_invoice_items_by_item_id
      invoice_items = InvoiceItem.find_all_by_item_id(1)
      assert invoice_items.count == 3
      assert invoice_items.each { |invoice_item| invoice_item.item_id == 1 }
    end

   ############################ Invoice_ID

    def test_it_finds_invoices_items_by_invoice_id
      invoice_item = InvoiceItem.find_by_invoice_id(2)
      assert invoice_item != nil
      assert invoice_item.invoice_id == 2
    end

    def test_it_finds_all_invoice_items_by_invoice_id
      invoice_items = InvoiceItem.find_all_by_invoice_id(2)
      assert invoice_items.count == 2
      assert invoice_items.each { |invoice_item| invoice_item.invoice_id == 2 }
    end

    ############################ Quanitity

    def test_it_finds_invoice_items_by_quantity
      invoice_item = InvoiceItem.find_by_quantity(9)
      assert invoice_item != nil
      assert invoice_item.quantity == 9
    end

    def test_it_finds_all_invoice_items_by_quantity
      invoice_items = InvoiceItem.find_all_by_quantity(9)
      assert invoice_items.count == 3
      assert invoice_items.each { |invoice_item| invoice_item.quantity == 9 }
    end

      ############################ Unit Price

    def test_it_finds_invoice_items_by_unit_price
      invoice_item = InvoiceItem.find_by_unit_price(BigDecimal.new('136.35'))
      assert invoice_item != nil
      assert invoice_item.unit_price == BigDecimal.new('136.35')
    end

    def test_it_finds_all_invoice_items_by_unit_price
      invoice_items = InvoiceItem.find_all_by_unit_price(BigDecimal.new('136.35'))
      assert invoice_items.count == 2
      assert invoice_items.each { |invoice_item| invoice_item == BigDecimal.new('136.35') }
    end

    ############################ Created_At

    def test_it_finds_invoice_items_by_created_at
      invoice_item = InvoiceItem.find_by_created_at('2012-03-27 14:54:09 UTC')
      assert invoice_item != nil
      assert invoice_item.created_at == '2012-03-27 14:54:09 UTC'
    end

    def test_it_finds_all_invoice_items_by_created_at
      invoice_items = InvoiceItem.find_all_by_created_at('2012-03-27 14:54:09 UTC')
      assert invoice_items.count == 2
      assert invoice_items.each { |invoice_item| invoice_item.created_at == '2012-03-27 14:54:09 UTC' }
    end

    ############################ Updated_At

    def test_it_finds_invoice_items_by_updated_at
      invoice_item = InvoiceItem.find_by_updated_at('2012-03-27 14:54:09 UTC')
      assert invoice_item != nil
      assert invoice_item.updated_at == '2012-03-27 14:54:09 UTC'
    end

    def test_it_finds_all_invoice_items_by_updated_at
      invoice_items = InvoiceItem.find_all_by_updated_at('2012-03-27 14:54:09 UTC')
      assert invoice_items.count == 2
      assert invoice_items.each { |invoice_item| invoice_item.updated_at == '2012-03-27 14:54:09 UTC' }
    end

    def test_it_finds_invoice_items_invoice
      contents = CSV.open './test/test_data/invoices_sample.csv', headers: true, header_converters: :symbol
      Invoice.build_invoice(contents)

      invoice_item = InvoiceItem.find_by_id(2)
      invoice = invoice_item.invoice
      assert invoice != nil
      assert_equal 1, invoice.id
      assert_equal 1, invoice.customer_id
      assert_equal 1, invoice.merchant_id
      assert_equal 'shipped', invoice.status
      assert_equal Date.parse('2012-03-25 09:54:09 UTC'), invoice.created_at
      assert_equal Date.parse('2012-03-25 09:54:09 UTC'), invoice.updated_at
    end

    def test_it_finds_invoice_items_item
      contents = CSV.open './test/test_data/items_sample.csv', headers: true, header_converters: :symbol
      Item.build_item(contents)

      invoice_item = InvoiceItem.find_by_id(3)
      item = invoice_item.item
      assert item != nil
      assert_equal 1, item.id
      assert_equal 'Item Qui Esse', item.name
      assert_equal 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.', item.description
      assert_equal BigDecimal.new('751.07'), item.unit_price
      assert_equal 1, item.merchant_id
      assert_equal '2012-03-27 01:53:59 UTC', item.created_at
      assert_equal '2012-03-27 01:53:59 UTC', item.updated_at
    end
  end
end
