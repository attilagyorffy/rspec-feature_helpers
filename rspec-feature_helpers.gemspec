# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/feature_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "rspec-feature_helpers"
  spec.version       = Rspec::FeatureHelpers::VERSION
  spec.authors       = ["Attila Györffy"]
  spec.email         = ["attila@attilagyorffy.com"]

  spec.summary       = %q{Opinionated RSpec helpers to enhance your feature specs}
  spec.description   = %q{A set of opinionated helpers to enhance testing features using RSpec.}
  spec.homepage      = "http://github.com/liquid/rspec-feature_helpers"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
