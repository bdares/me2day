# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'me2day/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'faraday', ['~> 0.8', '< 0.10']
  spec.add_dependency 'multi_json', '~> 1.0'
  spec.add_dependency 'simple_oauth', '~> 0.2'
  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.authors = ["Brian Park"]
  spec.description = %q{A Ruby interface to the Me2day API.}
  spec.email = ['bdares@gmail.com']
  spec.files = %w(.yardopts LICENSE.md README.md Rakefile me2day.gemspec)
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("spec/**/*")
  spec.homepage = 'http://bdares.github.com/me2day/'
  spec.licenses = ['MIT']
  spec.name = 'me2day'
  spec.require_paths = ['lib']
  spec.required_rubygems_version = '>= 1.3.6'
  spec.summary = spec.description
  spec.test_files = Dir.glob("spec/**/*")
  spec.version = Me2day::Version
end
