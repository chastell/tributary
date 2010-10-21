require './lib/tributary'

Tributary::App.configure do |config|
  config.set :author,   'Ary Tribut'
  config.set :root,     'spec/site'
  config.set :sitename, 'a tributary site'
end

run Tributary::App
