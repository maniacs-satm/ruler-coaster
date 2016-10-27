lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'ruler_coaster/version'

Gem::Specification.new do |gem|
  gem.name          = 'ruler_coaster'
  gem.version       = RulerCoaster::VERSION
  gem.authors       = ['Streetbees Dev Team']
  gem.email         = ['dev@streetbees.com']
  gem.description   = 'RulerCoaster'
  gem.summary       = 'Rule engine'
  gem.homepage      = 'https://github.com/streetbees/ruler-coaster'

  gem.files = Dir['README.md', 'lib/**/*']
  gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rubocop', '0.37.2'
  gem.add_development_dependency 'rspec', '~> 3.2'
  gem.add_development_dependency 'rake', '~> 0'
  gem.add_development_dependency 'pry', '~> 0'
end
