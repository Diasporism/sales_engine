require './test/support'

class InvoiceItemTest < MiniTest::Unit::TestCase
  def test_it_builds_invoice_items
    contents = CSV.open './data/invoice_items.csv', headers: true, header_converters: :symbol

    invoice_items = InvoiceItem.build_invoice_item(contents)
    assert_equal 21687, invoice_items
  end

  def test_invoice_items_have_correct_state
    data = {:id => '1', :item_id => '2', :invoice_id => '3', :quantity => '4',
            :unit_price => '5', :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

    invoice_item = InvoiceItem.new(data)
    assert_equal '1', invoice_item.id
    assert_equal '2', invoice_item.item_id
    assert_equal '3', invoice_item.invoice_id
    assert_equal '4', invoice_item.quantity
    assert_equal '5', invoice_item.unit_price
    assert_equal '2012-03-27 14:53:59 UTC', invoice_item.created_at
    assert_equal '2012-03-27 14:53:59 UTC', invoice_item.updated_at
  end
end