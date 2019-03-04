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

      def test_execute
        assert(@db.execute('tables', {schema: 'information_schema'}).present?)
      end
    end
  end
end
