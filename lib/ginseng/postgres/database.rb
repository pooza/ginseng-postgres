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
        dsn = Database.dsn
        dsn.dbname ||= default_dbname
        raise Ginseng::DatabaseError, "Invalid DSN '#{dsn}'" unless dsn.absolute?
        raise Ginseng::DatabaseError, "Invalid scheme '#{dsn.scheme}'" unless dsn.scheme == 'postgres'
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
        params.each do |k, v|
          params[k] = escape_string(v) if v.is_a?(String)
        end
        path = File.join(environment_class.constantize.dir, 'query', "#{name}.sql.erb")
        return ERB.new(File.read(path), nil, '-').result(binding).gsub(/\s+/, ' ').strip
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
