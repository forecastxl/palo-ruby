# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'palo/version'

Gem::Specification.new do |spec|
  spec.name          = "palo"
  spec.version       = Palo::VERSION
  spec.authors       = ["Arnold van der Meulen"]
  spec.email         = ["arnold@fmoor.nl"]
  spec.description   = %q{Palo DB Connector}
  spec.summary       = %q{Connect to a Jedox Palo OLAP Database}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency  'excon'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
