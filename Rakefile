dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(File.join(dir, 'lib'))
ENV['BUNDLE_GEMFILE'] ||= File.join(dir, 'Gemfile')

require 'bundler/setup'
require 'ginseng'
require 'ginseng/postgres'

namespace :bundle do
  desc 'update gems'
  task :update do
    sh 'bundle update'
  end

  desc 'check gems'
  task :check do
    unless Ginseng::Postgres::Environment.gem_fresh?
      warn 'gems is not fresh.'
      exit 1
    end
  end
end

desc 'test all'
task :test do
  ENV['TEST'] = Ginseng::Postgres::Package.name
  require 'test/unit'
  Dir.glob(File.join(Ginseng::Postgres::Environment.dir, 'test/*.rb')).sort.each do |t|
    require t
  end
end
