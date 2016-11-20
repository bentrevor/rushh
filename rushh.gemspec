# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'rushh'
  spec.version       = Rushh::VERSION
  spec.authors       = ['Ben Trevor']
  spec.email         = ['benjamin.trevor@gmail.com']
  spec.description   = 'write shell functions in ruby'
  spec.summary       = 'write shell functions in ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'pry'
end
