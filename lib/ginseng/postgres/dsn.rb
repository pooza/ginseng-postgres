module Ginseng
  module Postgres
    class DSN < Ginseng::URI
      def dbname
        return path.sub(%r{^/}, '')
      end

      def valid?
        return absolute? && scheme == 'postgres'
      end

      def to_h
        return {
          host:,
          user:,
          password:,
          dbname:,
          port:,
        }
      end
    end
  end
end
