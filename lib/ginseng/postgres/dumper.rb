module Ginseng
  module Postgres
    class Dumper
      include Package
      attr_reader :dsn, :extra_args
      attr_accessor :dest

      def initialize(params = {})
        self.dsn = Database.dsn
        @dest = create_temp_path
        @extra_args = [
          '--exclude-schema', 'repack'
        ]
      end

      def dsn=(dsn)
        @dsn = dsn
        @command = nil
      end

      def command
        unless @command
          @command ||= CommandLine.new([
            'pg_dump',
            '--host', @dsn.host || 'localhost',
            '--port', @dsn.port || 5432,
            '--username', @dsn.user || 'postgres',
            '--dbname', @dsn.dbname,
            '--file', dest
          ])
          @command.args.concat(extra_args)
          @command.env = {'PGPASSWORD' => @dsn.password} if @dsn.password
        end
        return @command
      end

      def exec
        command.exec
        raise "Bad status #{command.status}" unless command.status.zero?
      end

      def compress
        save unless File.exist?(dest)
        Ginseng::Gzip.compress(dest)
        @dest = "#{@dest}.gz"
      end

      private

      def create_temp_path
        return File.join(
          environment_class.dir,
          'tmp/cache/',
          "#{Time.now.to_s.adler32}.sql",
        )
      end
    end
  end
end
