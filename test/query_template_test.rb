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
    end
  end
end
