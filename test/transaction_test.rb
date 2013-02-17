require './test/support'

class TransactionTest < MiniTest::Unit::TestCase
  def setup
    contents = CSV.open './test/test_data/transactions_sample.csv', headers: true, header_converters: :symbol
    @transactions = Transaction.build_transaction(contents)
  end

  def teardown
    Transaction.clear
  end

  def test_there_are_merchants
    assert_equal 9, @transactions
  end

  def test_transactions_have_correct_state
    data = {:id => '1', :invoice_id => '2', :credit_card_number => '4654405418249632', :credit_card_expiration_date => '',
           :result => 'success', :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}
    transaction = Transaction.new(data)

    assert_equal 1, transaction.id
    assert_equal 2, transaction.invoice_id
    assert_equal 4654405418249632, transaction.credit_card_number
    assert_equal '', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:53:59 UTC', transaction.created_at
    assert_equal '2012-03-27 14:53:59 UTC', transaction.updated_at
  end

  def test_it_returns_random_transaction
    transaction_one = Transaction.random
    transaction_two = Transaction.random
    transaction_three = Transaction.random
    transaction_four = Transaction.random
    assert transaction_one != transaction_two || transaction_one != transaction_three || transaction_one != transaction_four
  end

  ############################ ID

  def test_it_finds_transactions_by_id
    transaction = Transaction.find_by_id(8)
    assert transaction != nil
    assert transaction.id == 8
  end

  def test_it_finds_all_transactions_by_id
    transactions = Transaction.find_all_by_id(8)
    assert transactions.each { |transaction| transaction.id == 8 }
  end

  ############################ Invoice_ID

  def test_it_finds_transactions_by_invoice_id
    transaction = Transaction.find_by_invoice_id(1)
    assert transaction != nil
    assert transaction.invoice_id == 1
  end

  def test_it_finds_all_transactions_by_invoice_id
    transactions = Transaction.find_all_by_invoice_id(1)
    assert_equal 2, transactions.count
    assert transactions.each { |transaction| transaction.invoice_id == 1 }
  end

  ############################ Credit_Card_Number

  def test_it_finds_transactions_by_credit_card_number
    transaction = Transaction.find_by_credit_card_number(4654405418249632)
    assert transaction != nil
    assert transaction.credit_card_number == 4654405418249632
  end

  def test_it_finds_all_transactions_by_credit_card_number
    transactions = Transaction.find_all_by_credit_card_number(4654405418249632)
    assert transactions.count == 3
    assert transactions.each { |transaction| transaction.credit_card_number == 4654405418249632 }
  end

  ############################ Result

  def test_it_finds_transactions_by_result
    transaction = Transaction.find_by_result('failed')
    assert transaction != nil
    assert transaction.result == 'failed'
  end

  def test_it_finds_all_transactions_by_result
    transactions = Transaction.find_all_by_result('failed')
    assert transactions.count == 2
    assert transactions.each { |transaction| transaction.result == 'failed' }
  end

  ############################ Created_At

  def test_it_finds_transactions_by_created_at
    transaction = Transaction.find_by_created_at('2012-03-27 08:54:10 UTC')
    assert transaction != nil
    assert transaction.created_at == '2012-03-27 08:54:10 UTC'
  end

  def test_it_finds_all_transactions_by_created_at
    transactions = Transaction.find_all_by_created_at('2012-03-27 08:54:10 UTC')
    assert transactions.count == 2
    assert transactions.each { |transaction| transaction.created_at == '2012-03-27 08:54:10 UTC' }
  end

  ############################ Updated_At

  def test_it_finds_transactions_by_updated_at
    transaction = Transaction.find_by_updated_at('2012-03-27 09:54:10 UTC')
    assert transaction != nil
    assert transaction.updated_at == '2012-03-27 09:54:10 UTC'
  end

  def test_it_finds_all_transactions_by_updated_at
    transactions = Transaction.find_all_by_updated_at('2012-03-27 09:54:10 UTC')
    assert transactions.count == 2
    assert transactions.each { |transaction| transaction.updated_at == '2012-03-27 09:54:10 UTC' }
  end

  def test_it_finds_transactions_invoices
    contents = CSV.open './test/test_data/invoices_sample.csv', headers: true, header_converters: :symbol
    Invoice.build_invoice(contents)

    transactions = Transaction.find_by_id(3)
    invoices = transactions.invoice
    assert_equal 1, invoices.merchant_id
  end
end
