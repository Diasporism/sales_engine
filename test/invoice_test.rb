require './test/support'

class InvoiceTest < MiniTest::Unit::TestCase

  def test_it_builds_invoices
    contents = CSV.open './data/invoices.csv', headers: true, header_converters: :symbol

    invoices = Invoice.build_invoice(contents)
    assert_equal 4843, invoices
  end

  def test_invoices_have_correct_state
    data = {:id => '1', :customer_id => '2', :merchant_id => '3', :status => 'shipped',
            :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

    invoice = Invoice.new(data)
    assert_equal '1', invoice.id
    assert_equal '2', invoice.customer_id
    assert_equal '3', invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '2012-03-27 14:53:59 UTC', invoice.created_at
    assert_equal '2012-03-27 14:53:59 UTC', invoice.updated_at
  end
end