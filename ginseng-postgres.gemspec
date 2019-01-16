require 'yaml'
package = YAML.load_file(File.join(__dir__, 'config/application.yaml'))['package']

Gem::Specification.new do |spec|
  spec.name = 'ginseng-postgres'
  spec.version = package['version']
  spec.authors = package['authors']
  spec.email = package['email']
  spec.summary = 'ginseng PostgreSQL libraries'
  spec.description = 'ginseng PostgreSQL libraries'
  spec.homepage = package['url']
  spec.license = 'MIT'
  spec.metadata['homepage_uri'] = package['url']
  spec.require_paths = ['lib']

  spec.add_dependency 'pg'
end
