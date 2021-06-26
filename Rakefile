dir = File.expand_path(__dir__)
$LOAD_PATH.unshift(File.join(dir, 'lib'))
ENV['BUNDLE_GEMFILE'] ||= File.join(dir, 'Gemfile')

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
task test: ['tmp:cache:clean'] do
  Ginseng::Postgres::TestCase.load((ARGV.first&.split(/[^[:word:],]+/) || [])[1])
end

namespace :tmp do
  namespace :cache do
    desc 'clean caches'
    task :clean do
      sh "rm #{File.join(Ginseng::Postgres::Environment.dir, 'tmp/cache/*.gz')}" rescue nil
    end

    desc 'alias of tmp:cache:clean'
    task clear: [:clean]
  end
end
