# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filtr/version'

Gem::Specification.new do |gem|
  gem.name          = "filtr"
  gem.version       = Filtr::VERSION
  gem.authors       = ["Hck"]
  gem.description   = %q{Gem for easy ActiveRecord/Mongoid models filtering}
  gem.summary       = %q{Filtr allows you to easily fetch ActiveRecord/Mongoid models that match specified filters.}
  gem.homepage      = "https://github.com/hck/filtr"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
