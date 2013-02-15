require './test/support'

class MerchantTest < MiniTest::Unit::TestCase

  def setup
    merchants = CSV.open './test/test_data/merchants_sample.csv', headers: true, header_converters: :symbol
    @merchants = Merchant.build_merchant(merchants)

  end

  def test_it_builds_merchants
    assert_equal 10, @merchants
  end

  def test_merchants_have_correct_state
    data = {:id => 1, :name => 'Schroeder-Jerde', :created_at => '2012-03-27 14:53:59 UTC',
            :updated_at => '2012-03-27 14:53:59 UTC'}

    merchant = Merchant.new(data)
    assert_equal 1, merchant.id
    assert_equal 'Schroeder-Jerde', merchant.name
    assert_equal '2012-03-27 14:53:59 UTC', merchant.created_at
    assert_equal '2012-03-27 14:53:59 UTC', merchant.updated_at
  end

  def test_it_returns_random_merchant
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
  end 

end














