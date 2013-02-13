require './test/support'

class TransactionTest < MiniTest::Unit::TestCase
  def test_there_are_merchants
    contents = CSV.open './data/transactions.csv', headers: true, header_converters: :symbol
    transactions = Transaction.build_transaction(contents)
    assert_equal 5595, transactions
  end

  def test_transactions_have_correct_state
    data = {:id => '1', :invoice_id => '2', :credit_card_number => '4654405418249632', :credit_card_expiration_date => '',
            :result => 'success', :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}
    transaction = Transaction.new(data)

    assert_equal '1', transaction.id
    assert_equal '2', transaction.invoice_id
    assert_equal '4654405418249632', transaction.credit_card_number
    assert_equal '', transaction.credit_card_expiration_date
    assert_equal 'success', transaction.result
    assert_equal '2012-03-27 14:53:59 UTC', transaction.created_at
    assert_equal '2012-03-27 14:53:59 UTC', transaction.updated_at
  end
end