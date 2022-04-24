module Ginseng
  module Postgres
    class QueryTemplate < Ginseng::Template
      include Package

      def initialize(name)
        name = name.to_s
        name += '.sql' unless name.end_with?('.sql')
        super
      end

      def params=(params)
        params.select {|_, v| v.is_a?(String)}.each do |k, v|
          params[k] = db.escape_string(v)
        end
        super
      end

      def []=(key, value)
        value = db.escape_string(value) if value.is_a?(String)
        super
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
