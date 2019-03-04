module Ginseng
  module Postgres
    module Package
      def environment_class
        return 'Ginseng::Postgres::Environment'
      end

      def package_class
        return 'Ginseng::Postgres::Package'
      end

      def config_class
        return 'Ginseng::Postgres::Config'
      end

      def database_class
        return 'Ginseng::Postgres::Database'
      end

      def query_template_class
        return 'Ginseng::Postgres::QueryTemplate'
      end

      def self.name
        return 'ginseng-postgres'
      end

      def self.version
        return Config.instance['/package/version']
      end

      def self.url
        return Config.instance['/package/url']
      end
    end
  end
end
