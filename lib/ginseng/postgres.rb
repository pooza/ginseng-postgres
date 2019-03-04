require 'active_support'
require 'active_support/core_ext'
require 'active_support/dependencies/autoload'
require 'ginseng'

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
