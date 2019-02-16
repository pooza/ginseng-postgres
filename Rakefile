dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(File.join(dir, 'lib'))
ENV['BUNDLE_GEMFILE'] ||= File.join(dir, 'Gemfile')
ENV['SSL_CERT_FILE'] ||= File.join(dir, 'cert/cacert.pem')
ENV['RAKE_MODULE'] = 'Ginseng::Postgres'

require 'bundler/setup'
require 'ginseng'
require 'ginseng/postgres'

desc 'test all'
task test: ['ginseng:postgres:test']

Dir.glob(File.join(Ginseng::Environment.dir, 'lib/task/*.rb')).each do |f|
  require f
end
Dir.glob(File.join(Ginseng::Postgres::Environment.dir, 'lib/task/*.rb')).each do |f|
  require f
end
