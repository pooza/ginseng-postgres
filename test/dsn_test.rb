module Ginseng
  module Postgres
    class DSNTest < Test::Unit::TestCase
      def setup
        @dsn = DSN.parse('postgres://postgres:nice_password@localhost:5432/mastodon')
      end

      def test_new
        assert_kind_of(DSN, @dsn)
      end

      def test_scheme
        assert_equal('postgres', @dsn.scheme)
      end

      def test_host
        assert_equal('localhost', @dsn.host)
      end

      def test_port
        assert_equal(5432, @dsn.port)
      end

      def test_dbname
        assert_equal('mastodon', @dsn.dbname)
      end

      def test_user
        assert_equal('postgres', @dsn.user)
      end

      def test_password
        assert_equal('nice_password', @dsn.password)
      end

      def test_to_h
        assert_equal({
          host: 'localhost',
          user: 'postgres',
          password: 'nice_password',
          dbname: 'mastodon',
          port: 5432,
        }, @dsn.to_h)
      end
    end
  end
end
