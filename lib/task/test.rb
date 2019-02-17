namespace :ginseng do
  namespace :postgres do
    task :test do
      ENV['TEST'] = Ginseng::Postgres::Package.name
      require 'test/unit'
      Dir.glob(File.join(Ginseng::Postgres::Environment.dir, 'test/*')).each do |t|
        require t
      end
    end
  end
end
