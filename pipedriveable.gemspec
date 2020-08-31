# frozen_string_literal: true

require_relative "lib/pipedriveable/version"

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name        = "pipedriveable"
  gem.version     = Pipedriveable::VERSION
  gem.summary     = "Gem for building Pipedrive integrations"
  gem.authors     = ["Lauri Jutila"]
  gem.email       = "github@laurijutila.com"
  gem.files       = Dir["{lib}/**/*", "Rakefile"]

  gem.license     = "MIT"

  gem.add_dependency "dry-types"
  gem.add_dependency "dry-struct"
  gem.add_dependency "dry-validation"
  gem.add_dependency "dry-monads"

  gem.add_development_dependency "rspec", ">= 3.9"
  gem.add_development_dependency "rspec-collection_matchers"
  gem.add_development_dependency "fuubar", "~> 2.5"
  gem.add_development_dependency "rspec-instafail", "~> 1.0"
  gem.add_development_dependency "rspec_junit_formatter", "~> 0.4"

  gem.add_development_dependency "bundler", ">= 2"
  gem.add_development_dependency "pry-byebug", "~> 3.6"
  gem.add_development_dependency "rake", "~> 13.0"
  gem.add_development_dependency "factory_bot"
end