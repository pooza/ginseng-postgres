module Ginseng
  module Postgres
    class DSN < Ginseng::URI
      def dbname
        return path.sub(%r{^/}, '')
      end

      def to_h
        return {
          host: host,
          user: user,
          password: password,
          dbname: dbname,
          port: port,
        }
      end
    end
  end
end
