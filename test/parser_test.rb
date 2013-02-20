require './test/support'

module SalesEngine
  class ParserTest < MiniTest::Unit::TestCase
    def test_it_loads_files
      contents = CSV.open './test/test.csv', headers: true, header_converters: :symbol
      assert_equal 3, contents.count
    end
  end
end
