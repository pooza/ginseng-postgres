dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(File.join(dir, 'lib'))
ENV['BUNDLE_GEMFILE'] ||= File.join(dir, 'Gemfile')

require 'bundler/setup'
require 'ginseng'
require 'ginseng/postgres'

desc 'test all'
task test: 'ginseng:postgres:test'

Dir.glob(File.join(Ginseng::Postgres::Environment.dir, 'lib/task/*.rb')).each do |f|
  require f
end
