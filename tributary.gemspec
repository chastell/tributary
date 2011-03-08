# FIXME: a RubyGems 1.6.1 and/or Ruby 1.9.2p180 workaround to
# keep gem metadata Syck-built (and, thus, work on RubyGems/Heroku)
YAML::ENGINE.yamler = 'syck'

Gem::Specification.new do |gem|
  gem.name     = 'tributary'
  gem.version  = '0.0.3'
  gem.summary  = 'tributary: a tiny, toto-inspired blogging engine'
  gem.homepage = 'http://github.com/chastell/tributary'
  gem.author   = 'Piotr Szotkowski'
  gem.email    = 'chastell@chastell.net'

  gem.files      = `git ls-files -z`.split "\0"
  gem.test_files = Dir['spec/**/*.rb']

  gem.add_dependency 'haml'
  gem.add_dependency 'kramdown'
  gem.add_dependency 'sinatra', '>= 1.1.2'
  gem.add_dependency 'sinatra-r18n'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rspec', '>= 2'
end
