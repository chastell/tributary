require 'spec/rake/spectask'

ENV['TZ'] = 'Europe/Warsaw'

Spec::Rake::SpecTask.new :spec

require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.authors  = ['Piotr Szotkowski']
  gem.email    = 'chastell@chastell.net'
  gem.homepage = 'http://github.com/chastell/tributary'
  gem.name     = 'tributary'
  gem.summary  = 'tributary: a tiny, toto-inspired blogging engine'

  gem.add_dependency 'haml'
  gem.add_dependency 'kramdown'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-r18n'

  gem.add_development_dependency 'diff-lcs'
  gem.add_development_dependency 'jeweler'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'rspec'
end
