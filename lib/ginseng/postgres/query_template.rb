module Ginseng
  module Postgres
    class QueryTemplate < Ginseng::Template
      include Package

      # ginseng-upstream: no — `.sql` を補うのは SQL のテンプレートの事情
      def initialize(name)
        name = name.to_s
        name += '.sql' unless name.end_with?('.sql')
        super
      end

      # ginseng-upstream: no — 値を SQL 向けにエスケープするのは SQL の事情（⚠ 引数を書き換える不具合は #118）
      def params=(params)
        params.select {|_, v| v.is_a?(String)}.each do |k, v|
          params[k] = db.escape_string(v)
        end
        super
      end

      # ginseng-upstream: no — 値を SQL 向けにエスケープするのは SQL の事情
      def []=(key, value)
        value = db.escape_string(value) if value.is_a?(String)
        super
      end

      def escape(value)
        return db.escape_string(value.to_s)
      end

      # ginseng-upstream: no — 空白を詰めるのは SQL を 1 行にするため
      def to_s
        return super.gsub(/\s+/, ' ').strip
      end

      private

      def db
        return database_class.instance
      end

      def dir
        return 'query'
      end
    end
  end
end
