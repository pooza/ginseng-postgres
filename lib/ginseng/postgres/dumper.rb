module Ginseng
  module Postgres
    class Dumper
      attr_reader :dsn
      attr_accessor :dest

      def initialize(params = {})
        dsn = Database.dsn
      end

      def dsn=(dsn)
        @dsn = dsn
        @command = nil
        @dump = nil
      end

      def command
        unless @command
          @command ||= CommandLine.new([
            'pg_dump',
            '--host', @dsn.host || 'localhost',
            '--port', @dsn.port || 5432,
            '--username', @dsn.user || 'postgres',
            '--dbname', @dsn.dbname,
            '--exclude-schema', 'repack'
          ])
          @command.env = {'PGPASSWORD' => @dsn.password} if @dsn.password
        end
        return @command
      end

      def exec
        unless @dump
          command.exec
          raise "Bad status #{command.status}" unless command.status.zero?
          @dump = command.stdout
        end
        return @dump
      end

      def save
        raise '"dest" undefined' unless dest
        exec unless @dump
        File.write(dest, @dump)
      end

      def compress
        save unless File.exist?(dest)
        Ginseng::Gzip.compress(dest)
        @dest = "#{@dest}.gz"
      end
    end
  end
end
