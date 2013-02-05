# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filtr/version'

Gem::Specification.new do |gem|
  gem.name          = "filter_factory"
  gem.version       = FilterFactory::VERSION
  gem.authors       = ["Hck"]
  gem.description   = %q{Gem for easy ActiveRecord/Mongoid models filtering}
  gem.summary       = %q{FilterFactory allows you to easily fetch ActiveRecord/Mongoid models that match specified filters.}
  gem.homepage      = "https://github.com/hck/filter_factory"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
