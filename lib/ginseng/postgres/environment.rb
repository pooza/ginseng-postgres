module Ginseng
  module Postgres
    class Environment < Ginseng::Environment
      def self.name
        return File.basename(dir)
      end

      def self.dir
        return Ginseng::Postgres.dir
      end
    end
  end
end
