# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dish/version'

Gem::Specification.new do |spec|
  spec.name          = "dish"
  spec.version       = Dish::VERSION
  spec.authors       = ["Lasse Bunk"]
  spec.email         = ["lassebunk@gmail.com"]
  spec.summary       = %q{Super simple conversion of hashes to plain Ruby objects}
  spec.description   = %q{Super simple conversion of hashes to plain Ruby objects. Great for consuming JSON API's.}
  spec.homepage      = "https://github.com/lassebunk/dish"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^test/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
