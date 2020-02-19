require 'ginseng'
require 'active_support/dependencies/autoload'

module Ginseng
  module Postgres
    extend ActiveSupport::Autoload

    autoload :Config
    autoload :Database
    autoload :DSN
    autoload :Environment
    autoload :Package
    autoload :QueryTemplate
  end
end
