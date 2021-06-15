require 'bundler/setup'

module Ginseng
  module Postgres
    def self.dir
      return File.expand_path('../..', __dir__)
    end

    def self.loader
      config = YAML.load_file(File.join(dir, 'config/autoload.yaml'))
      loader = Zeitwerk::Loader.new
      loader.inflector.inflect(config['inflections'])
      loader.push_dir(File.join(dir, 'lib/ginseng/postgres'), namespace: Ginseng::Postgres)
      return loader
    end

    Bundler.require
    loader.setup
  end
end
