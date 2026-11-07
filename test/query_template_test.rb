module Ginseng
  module Postgres
    class QueryTemplateTest < Test::Unit::TestCase
      def setup
        @template = QueryTemplate.new(:tables)
      end

      def test_new
        assert_kind_of(QueryTemplate, @template)
      end

      def test_param
        @template[:schema] = 'fuga'

        assert_equal('fuga', @template.params[:schema])
        @template[:schema] = 'hogehoge'

        assert_equal('hogehoge', @template.params[:schema])
      end

      def test_params
        @template.params = {'schema' => 'hoge'}

        assert_equal('hoge', @template.params[:schema])
        @template.params = {schema: 'information_schema'}

        assert_equal('information_schema', @template.params[:schema])
      end

      def test_to_s
        @template.params = {schema: 'information_schema'}

        assert_equal(%(SELECT * FROM information_schema.tables WHERE table_schema='information_schema'), @template.to_s)
      end

      def test_params_does_not_modify_argument
        params = {schema: "O'Reilly"}
        @template.params = params

        assert_equal({schema: "O'Reilly"}, params)
        assert_equal("O''Reilly", @template.params[:schema])
      end

      def test_params_accepts_frozen_hash
        @template.params = {schema: "O'Reilly"}.freeze

        assert_equal("O''Reilly", @template.params[:schema])
      end

      def test_params_escapes_once_when_reused
        params = {schema: "O'Reilly"}
        @template.params = params
        first = @template.to_s
        @template.params = params

        assert_equal(first, @template.to_s)
        assert_include(first, "table_schema='O''Reilly'")
      end

      def test_escape
        assert_equal('test', @template.escape('test'))
        assert_equal("O''Reilly", @template.escape("O'Reilly"))
        assert_equal('100%', @template.escape('100%'))
      end
    end
  end
end
