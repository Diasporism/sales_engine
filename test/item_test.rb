require './test/support'

class ItemTest < MiniTest::Unit::TestCase
  def test_it_builds_items
    contents = CSV.open './data/items.csv', headers: true, header_converters: :symbol

    items = Item.build_item(contents)
    assert_equal 2483, items
  end

  def test_items_have_correct_state
    data = {:id => '1', :name => 'Bob', :description => 'description', :unit_price => '2',
            :merchant_id => '3', :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

    item = Item.new(data)
    assert_equal '1', item.id
    assert_equal 'Bob', item.name
    assert_equal 'description', item.description
    assert_equal '2', item.unit_price
    assert_equal '3', item.merchant_id
    assert_equal '2012-03-27 14:53:59 UTC', item.created_at
    assert_equal '2012-03-27 14:53:59 UTC', item.updated_at
  end
end