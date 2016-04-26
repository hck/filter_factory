lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filter_factory/version'

Gem::Specification.new do |gem|
  gem.name          = 'filter_factory'
  gem.version       = FilterFactory::VERSION
  gem.authors       = ['Hck']
  gem.description   = 'Gem for easy ActiveRecord/Mongoid models filtering'
  gem.summary       = 'FilterFactory allows you to easily fetch ActiveRecord/Mongoid models that match specified filters.'
  gem.homepage      = 'https://github.com/hck/filter_factory'

  gem.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
end
