lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'bundler/version'

Gem::Specification.new do |gem|
  gem.name        = 'sales_engine'
  gem.version     = '1.0.0'
  gem.summary     = "Sales Engine"
  gem.description = "Sales Engine"
  gem.authors     = ["Logan Sears", "Chelsea Komlo"]
  gem.email       = 'lsears322@gmail.com'
  gem.files         = Dir["{data, lib}/**/*"] + %w(
                        sales_engine.gemspec
                      )
  gem.homepage    = 'https://github.com/diasporism/sales_engine'

  gem.required_ruby_version  = '>=1.9'
end