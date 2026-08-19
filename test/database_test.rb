module Ginseng
  module Postgres
    class DatabaseTest < Test::Unit::TestCase
      def setup
        @db = Database.instance
      end

      def test_connection
        assert_kind_of(Sequel::Database, @db.connection)
      end

      def test_convert_infinite_timestamps
        assert_equal(:nil, @db.connection.convert_infinite_timestamps)
      end

      def test_escape_string
        assert_equal('あえ', @db.escape_string('あえ'))
        assert_equal(%(あえ"), @db.escape_string(%(あえ")))
        assert_equal(%(あえ''), @db.escape_string(%(あえ')))
      end

      def test_execute
        assert_predicate(@db.execute('tables', {schema: 'information_schema'}), :present?)
        @db.execute('tables', {schema: 'information_schema'}).each do |row|
          assert_kind_of(Hash, row)
        end
      end
    end
  end
end
