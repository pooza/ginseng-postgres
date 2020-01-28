module Ginseng
  module Postgres
    class QueryTemplate < Ginseng::Template
      include Package

      def initialize(name)
        name += '.sql' unless /\.sql$/.match?(name)
        super(name)
      end

      def params=(params)
        params.each do |k, v|
          params[k] = db.escape_string(v) if v.is_a?(String)
        end
        super(params)
      end

      def []=(key, value)
        value = db.escape_string(value) if value.is_a?(String)
        super(key, value)
      end

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
