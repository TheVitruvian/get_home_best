# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'get_home_best/version'

Gem::Specification.new do |spec|
  spec.name          = "get_home_best"
  spec.version       = GetHomeBest::VERSION
  spec.authors       = ["TheVitruvian"]
  spec.email         = ["Alexham100@aol.com"]
  spec.description   = %q{Decide how to get home best}
  spec.summary       = %q{Decide how to get home best}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"

  spec.add_dependency "httparty", "~> 0.12.0"
  spec.add_dependency "curb"
  spec.add_dependency 'mechanize'


end
