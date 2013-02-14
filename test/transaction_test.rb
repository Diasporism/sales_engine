# require './test/support'

# class TransactionTest < MiniTest::Unit::TestCase
#    def test_there_are_merchants
#      contents = CSV.open './data/transactions.csv', headers: true, header_converters: :symbol
#      transactions = Transaction.build_transaction(contents)
#      assert_equal 5595, transactions
#    end

#    def test_transactions_have_correct_state
#      data = {:id => '1', :invoice_id => '2', :credit_card_number => '4654405418249632', :credit_card_expiration_date => '',
#              :result => 'success', :created_at => '2012-03-27 14:53:59 UTC', :updated_at => '2012-03-27 14:53:59 UTC'}
#      transaction = Transaction.new(data)

#      assert_equal '1', transaction.id
#      assert_equal '2', transaction.invoice_id
#      assert_equal '4654405418249632', transaction.credit_card_number
#      assert_equal '', transaction.credit_card_expiration_date
#      assert_equal 'success', transaction.result
#      assert_equal '2012-03-27 14:53:59 UTC', transaction.created_at
#      assert_equal '2012-03-27 14:53:59 UTC', transaction.updated_at
#    end

#    def test_it_returns_random_transaction
#      transaction_one = Transaction.random
#      transaction_two = Transaction.random
#      transaction_three = Transaction.random
#      assert transaction_one != transaction_two
#      assert transaction_two != transaction_three
#      assert transaction_three != transaction_one
#    end

#    ############################ ID

#    def test_it_finds_transactions_by_id
#      transaction = Transaction.find_by_id(8)
#      assert customer.id == 8
#    end

#    def test_it_finds_all_transactions_by_id
#      transactions = Transaction.find_all_by_id(8)
#      assert transactions.each { |transaction| transaction.id == 8 }
#    end

#    ############################ Invoice_ID

#    def test_it_finds_transactions_by_invoice_id
#      transaction = Transaction.find_by_invoice_id(1)
#      assert transaction.invoice_id == 1
#    end

#    def test_it_finds_all_transactions_by_invoice_id
#      transactions = Transaction.find_all_by_invoice_id(2)
#      assert transactions.count == 2
#      assert transactions.each { |transaction| transaction.invoice_id == 2 }
#    end

#    ############################ Credit_Card_Number

#    def test_it_finds_transactions_by_credit_card_number
#      transaction = Transaction.find_by_credit_card_number(4654405418249632)
#      assert transaction.credit_card_number == 4654405418249632
#    end

#    def test_it_finds_all_transactions_by_credit_card_number
#      transactions = Transaction.find_all_by_credit_card_number(4654405418249632)
#      assert transactions.count == 3
#      assert transactions.each { |transaction| transaction.credit_card_number == 4654405418249632 }
#    end

#    ############################ Credit_Card_Expiration_Date

#    def test_it_finds_transactions_by_credit_card_expiration_date
#      transaction = transaction.find_by_credit_card_expiration_date('')
#      assert transaction.credit_card_expiration_date == ''
#    end

#    def test_it_finds_all_transactions_by_credit_card_expiration_date
#      transactions = transaction.find_all_by_credit_card_expiration_date('')
#      assert transactions.count == 0
#      assert transactions.each { |transaction| transaction.credit_card_expiration_date == '' }
#    end

#      ############################ Result

#    def test_it_finds_transactions_by_result
#      transaction = transaction.find_by_result('success')
#      assert transaction.result == 'success'
#    end

#    def test_it_finds_all_transactions_by_result
#      transactions = transaction.find_all_by_result('success')
#      assert transactions.count == 9
#      assert transactions.each { |transaction| transaction.result == 'success' }
#    end

#    ############################ Created_At

#    def test_it_finds_transactions_by_created_at
#      transaction = transaction.find_by_created_at('4:54:10 UTC')
#      assert transaction.created_at == '4:54:10 UTC'
#    end

#    def test_it_finds_all_transactions_by_created_at
#      transactions = transaction.find_all_by_created_at('4:54:10 UTC')
#      assert transactions.count == 7
#      assert transactions.each { |transaction| transaction.created_at == '4:54:10 UTC' }
#    end

#      ############################ Updated_At

#    def test_it_finds_transactions_by_updated_at
#      transaction = Transactions.find_by_updated_at('14:54:10 UTC')
#      assert transaction.updated_at == '14:54:10 UTC'
#    end

#    def test_it_finds_all_transactions_by_updated_at
#      transactions = Transaction.find_all_by_updated_at('14:54:10 UTC')
#      assert transactions.count == 7
#      assert transactions.each { |transaction| transaction.updated_at == '14:54:10 UTC' }
#    end
# end