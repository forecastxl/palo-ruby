# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'palo/version'

Gem::Specification.new do |spec|
  spec.name          = 'palo-ruby'
  spec.version       = Palo::VERSION
  spec.authors       = ['ForecastXL']
  spec.email         = ['developers@forecastxl.com']
  spec.summary       = %q{Ruby client to connect with a Jedox Palo OLAP Database}
  spec.homepage      = 'https://www.forecastxl.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency  'excon'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
