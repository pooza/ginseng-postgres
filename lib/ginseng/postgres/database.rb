require 'sequel'
require 'pg'
require 'erb'
require 'singleton'

module Ginseng
  module Postgres
    class Database
      include Singleton
      include Package
      attr_reader :connection

      def initialize
        @config = config_class.instance
        dsn = database_class.dsn
        raise Ginseng::DatabaseError, 'Invalid DSN' unless dsn.absolute?
        raise Ginseng::DatabaseError, 'Invalid scheme' unless dsn.scheme == 'postgres'
        @connection = Sequel.connect(dsn.to_s)
      rescue => e
        raise Ginseng::DatabaseError, e.message, e.backtrace
      end

      def escape_string(value)
        return PG::Connection.escape_string(value)
      end

      def create_sql(name, params = {})
        template = query_template_class.new(name)
        template.params = params
        return template.to_s
      end

      def execute(name, params = {})
        return @connection.fetch(create_sql(name, params)).all
      rescue => e
        raise Ginseng::DatabaseError, e.message, e.backtrace
      end

      def self.dsn
        return DSN.parse(Config.instance['/postgres/dsn'])
      end
    end
  end
end
