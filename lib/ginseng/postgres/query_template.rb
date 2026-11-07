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

      # ginseng-upstream: no — 値を SQL 向けにエスケープするのは SQL の事情
      # ⚠ 引数には書き戻さない（#118）。書き戻すと呼び出し側の Hash が変わり、同じ Hash を
      # もう一度渡したときに二重にエスケープされる。凍結した Hash も渡せなくなる。
      def params=(params)
        super(params.transform_values {|v| v.is_a?(String) ? db.escape_string(v) : v})
      end

      # ginseng-upstream: no — 値を SQL 向けにエスケープするのは SQL の事情
      def []=(key, value)
        value = db.escape_string(value) if value.is_a?(String)
        super
      end

      def escape(value)
        return db.escape_string(value.to_s)
      end

      # ginseng-upstream: no — 空白を詰めてよいのは SQL だから（HTML などでは空白に意味があり、詰めると壊れる）
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
