module Ginseng
  module Postgres
    module Package
      def module_name
        return 'Ginseng::Postgres'
      end

      def environment_class
        return "#{module_name}::Environment".constantize
      end

      def package_class
        return "#{module_name}::Package".constantize
      end

      def config_class
        return "#{module_name}::Config".constantize
      end

      def database_class
        return "#{module_name}::Database".constantize
      end

      def query_template_class
        return "#{module_name}::QueryTemplate".constantize
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
