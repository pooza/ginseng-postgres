require 'pg'
require 'erb'
require 'singleton'

module Ginseng
  module Postgres
    class Database
      include Singleton
      include Package

      def initialize
        @config = config_class.constantize.instance
        dsn = database_class.constantize.dsn
        dsn.dbname ||= default_dbname
        raise Ginseng::DatabaseError, 'Invalid DSN' unless dsn.absolute?
        raise Ginseng::DatabaseError, 'Invalid scheme' unless dsn.scheme == 'postgres'
        @db = PG.connect(dsn.to_h)
      rescue PG::Error => e
        raise Ginseng::DatabaseError, e.message
      end

      def default_dbname
        return ''
      end

      def escape_string(value)
        return @db.escape_string(value)
      end

      def create_sql(name, params = {})
        template = query_template_class.constantize.new(name)
        template.params = params
        return template.to_s
      end

      def execute(name, params = {})
        return @db.exec(create_sql(name, params)).to_a
      rescue PG::Error => e
        raise Ginseng::DatabaseError, e.message
      end

      def self.dsn
        return DSN.parse(Config.instance['/postgres/dsn'])
      end
    end
  end
end
