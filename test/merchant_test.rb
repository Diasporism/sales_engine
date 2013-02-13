require './test/support'

class MerchantTest < MiniTest::Unit::TestCase
  def test_it_builds_merchants
    contents = CSV.open './data/merchants.csv', headers: true, header_converters: :symbol

    merchants = Merchant.build_merchant(contents)
    assert_equal 100, merchants
  end

  def test_merchants_have_correct_state
    data = {:id => '1', :name => 'Schroeder-Jerde', :created_at => '2012-03-27 14:53:59 UTC',
            :updated_at => '2012-03-27 14:53:59 UTC'}

    merchant = Merchant.new(data)
    assert_equal '1', merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
    assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at
    assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at
  end
end
