# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'submail/version'

Gem::Specification.new do |spec|
  spec.name          = "submail"
  spec.version       = Submail::VERSION
  spec.authors       = ["Chen Yi-Cyuan"]
  spec.email         = ["emn178@gmail.com"]
  spec.description   = %q{Submail client api.}
  spec.summary       = %q{Submail client api.}
  spec.homepage      = "https://github.com/emn178/submail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rspec-its", "~> 1.2.0"
end
