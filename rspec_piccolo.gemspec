# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec_piccolo/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec_piccolo'
  spec.version       = RSpecPiccolo::VERSION
  spec.authors       = ['tbpgr']
  spec.email         = ['tbpgr@tbpgr.jp']
  spec.description   = %q(generate rspec spec_file with list_cases)
  spec.summary       = %q(generate rspec spec_file with list_cases)
  spec.homepage      = 'https://github.com/tbpgr/rspec_piccolo'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 4.0.1'
  spec.add_runtime_dependency 'thor', '~> 0.18.1'
  spec.add_runtime_dependency 'tbpgr_utils', '~> 0.0.4'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'simplecov', '~> 0.8.2'
end
