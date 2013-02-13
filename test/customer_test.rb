require './test/support'

class CustomerTest < MiniTest::Unit::TestCase
  def setup
    contents = CSV.open './test/test_data/customers_sample.csv', headers: true, header_converters: :symbol
    @customers = Customer.build_customer(contents)
  end

  def test_it_builds_customers
    assert_equal 1000, @customers
  end

  def test_customers_have_correct_state
    data = {:id => '1', :first_name => 'Thomas', :last_name => 'Jefferson',
            :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

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
    assert customer_one != customer_two
    assert customer_two != customer_three
    assert customer_three != customer_one
  end

  ############################ ID

  def test_it_finds_by_id
    customer = Customer.find_by_id(8)
    assert customer.id == 8
  end

  def test_it_finds_all_by_id
    customers = Customer.find_all_by_id(8)
    assert customers.each { |customer| customer.id == 8 }
  end

  ############################ First_Name

  def test_it_finds_by_first_name
    customer = Customer.find_by_first_name('Magnus')
    assert customer.first_name == 'magnus'
  end

  def test_it_finds_all_by_first_name
    customers = Customer.find_all_by_first_name('Magnus')
    assert customers.count == 2
    assert customers.each { |customer| customer.first_name == 'magnus' }
  end

  ############################ Last_Name

  def test_it_finds_by_last_name
    customer = Customer.find_by_last_name('Nader')
    assert customer.last_name == 'nader'
  end

  def test_it_finds_all_by_last_name
    customers = Customer.find_all_by_last_name('Nader')
    assert customers.count == 3
    assert customers.each { |customer| customer.last_name == 'nader' }
  end

  ############################ Created_At

  def test_it_finds_by_created_at
    customer = Customer.find_by_created_at('')
    assert customer.created_at == ''
  end

  def test_it_finds_all_by_created_at
    customers = Customer.find_all_by_created_at('')
    assert customers.count ==
    assert customers.each { |customer| customer.created_at == '' }
  end

  ############################ Updated_At

  def test_it_finds_by_updated_at
    customer = Customer.find_by_updated_at('')
    assert customer.updated_at == ''
  end

  def test_it_finds_all_by_updated_at
    customers = Customer.find_all_by_updated_at('')
    assert customers.count ==
    assert customers.each { |customer| customer.updated_at == '' }
  end
end