require './test/support'

class InvoiceTest < MiniTest::Unit::TestCase

  def test_it_builds_invoices
    contents = CSV.open './data/invoices.csv', headers: true, header_converters: :symbol

    invoices = Invoice.build_invoice(contents)
    assert_equal 4843, invoices
  end

  def test_invoices_have_correct_state
    data = {:id => '1', :invoice_id => '2', :merchant_id => '3', :status => 'shipped',
            :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}

    invoice = Invoice.new(data)
    assert_equal '1', invoice.id
    assert_equal '2', invoice.invoice_id
    assert_equal '3', invoice.merchant_id
    assert_equal 'shipped', invoice.status
    assert_equal '2012-03-27 14:53:59 UTC', invoice.created_at
    assert_equal '2012-03-27 14:53:59 UTC', invoice.updated_at
  end

  def test_it_returns_random_invoice
    invoice_one = invoice.random
    invoice_two = invoice.random
    invoice_three = invoice.random
    invoice_four = invoice.random
    assert invoice_one != nil
    assert invoice_two != nil
    assert invoice_three != nil
    assert invoice_one != invoice_two || invoice_one != invoice_three || invoice_one != invoice_four
  end

  ############################ ID

  def test_it_finds_invoices_by_id
    invoice = Invoice.find_by_id(8)
    assert invoice != nil
    assert invoice.id == 8
  end

  def test_it_finds_all_invoices_by_id
    invoices = Invoice.find_all_by_id(8)
    assert invoices.count == 1
    assert invoices.each { |invoice| invoice.id == 8 }
  end

  ############################ Customer_ID

  def test_it_finds_invoices_by_customer_id
    invoice = Invoice.find_by_customer_id(1)
    assert invoice != nil
    assert_equal invoice.customer_id, 1
  end

  def test_it_finds_all_invoices_by_customer_id
    invoices = Invoice.find_all_by_customer_id('Joey')
    assert invoices.count == 2
    assert invoices.each { |invoice| invoice.customer_id == 'Joey' }
  end

  ############################ Merchant_ID

  def test_it_finds_invoices_by_merchant_id
    invoice = Invoice.find_by_merchant_id(26)
    assert invoice != nil
    assert invoice.merchant_id == 26
  end

  def test_it_finds_all_invoices_by_merchant_id
    invoices = Invoice.find_all_by_merchant_id(26)
    assert invoices.count == 2
    assert invoices.each { |invoice| invoice.merchant_id == 26 }
  end

    ############################ Status

  def test_it_finds_invoices_by_status
    invoice = Invoice.find_by_status('shipped')
    assert invoice != nil
    assert invoice.status == 'shipped'
  end

  def test_it_finds_all_invoices_by_status
    invoices = Invoice.find_all_by_status('shipped')
    assert invoices.count == 10
    assert invoices.each { |invoice| invoice.status == 'shipped' }
  end

  ############################ Created_At

  def test_it_finds_invoices_by_created_at
    invoice = Invoice.find_by_created_at('2012-03-25 09:54:09 UTC')
    assert invoice != nil
    assert invoice.created_at == '2012-03-25 09:54:09 UTC'
  end

  def test_it_finds_all_invoices_by_created_at
    invoices = Invoice.find_all_by_created_at('2012-03-25 09:54:09 UTC')
    assert invoices.count == 2
    assert invoices.each { |invoice| invoice.created_at == '2012-03-25 09:54:09 UTC' }
  end

  ############################ Updated_At

  def test_it_finds_invoices_by_updated_at
    invoice = Invoice.find_by_updated_at('2012-03-25 09:54:09 UTC')
    assert invoice != nil
    assert invoice.updated_at == '2012-03-25 09:54:09 UTC'
  end

  def test_it_finds_all_invoices_by_updated_at
    invoices = Invoice.find_all_by_updated_at('2012-03-25 09:54:09 UTC')
    assert invoices.count == 2
    assert invoices.each { |invoice| invoice.updated_at == '2012-03-25 09:54:09 UTC' }
  end

end