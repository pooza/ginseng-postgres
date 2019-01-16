module Ginseng
  module Postgres
    class DatabaseTest < Test::Unit::TestCase
      def setup
        @db = Database.instance
      end

      def test_escape_string
        assert_equal(@db.escape_string('あえ'), 'あえ')
        assert_equal(@db.escape_string(%(あえ")), %(あえ\"))
        assert_equal(@db.escape_string(%(あえ')), %(あえ''))
      end

      def test_create_sql
        assert_equal(@db.create_sql('tables'), 'SELECT * FROM information_schema.tables')
        assert_equal(@db.create_sql('tables', {schema: 'information_schema'}), %(SELECT * FROM information_schema.tables WHERE table_schema='information_schema'))
      end

      def test_execute
        assert_true(@db.execute('tables', {schema: 'information_schema'}).present?)
      end
    end
  end
end
