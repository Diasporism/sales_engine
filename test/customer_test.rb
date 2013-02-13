require './test/support'

class CustomerTest < MiniTest::Unit::TestCase
  def test_there_are_customers
    contents = CSV.open './data/customers.csv', headers: true, header_converters: :symbol
    customers = Customer.build_customer(contents)
    assert_equal 1000, customers
  end

  def test_customers_have_correct_state
    data = {:id => '1', :first_name => 'Thomas', :last_name => 'Jefferson',
            :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}
    customer = Customer.new(data)

    assert_equal '1', customer.id
    assert_equal 'Thomas', customer.first_name
    assert_equal 'Jefferson', customer.last_name
    assert_equal '2012-03-27 14:53:59 UTC', customer.created_at
    assert_equal '2012-03-27 14:53:59 UTC', customer.updated_at
  end
end