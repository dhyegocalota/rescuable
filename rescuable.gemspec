require './lib/rescuable/version'

Gem::Specification.new do |spec|
  spec.name        = 'rescuable'
  spec.version     = Rescuable::Version::STRING
  spec.authors     = ['Dhyego Fernando']
  spec.email       = ['dhyegofernando@gmail.com']

  spec.summary     = 'Render an error in JSON format with support for I18n.'
  spec.description = spec.summary
  spec.homepage    = 'http://github.com/dhyegofernando/rescuable'
  spec.license     = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'i18n', '~> 0.6'
  spec.add_dependency 'activesupport', '~> 4.0'
  spec.add_dependency 'railties', '~> 4.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-utils'
  spec.add_development_dependency 'pry-meta'
end
