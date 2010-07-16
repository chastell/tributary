require 'lib/tributary'

Tributary::App.configure do |config|
  config.set :author,   'Ary Tribut'
  config.set :root,     'spec/fixtures'
  config.set :sitename, 'a tributary site'
  config.set :url,      'http://tributary.example.net/'
end

run Tributary::App
