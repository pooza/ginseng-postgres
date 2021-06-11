module Ginseng
  module Postgres
    class Dumper
      attr_accessor :dsn, :dest

      def initialize(params = {})
        @dsn = Database.dsn
      end

      def command
        unless @command
          @command ||= CommandLine.new([
            'pg_dump',
            '--exclude-schema', 'repack',
            '--host', @dsn.host,
            '--port', @dsn.port.to_s,
            '--username', @dsn.user,
            '--dbname', @dsn.dbname
          ])
          @command.env = {'PGPASSWORD' => @dsn.password}
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
