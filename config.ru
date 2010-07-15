require 'lib/tributary'

Tributary::App.configure do |config|
  config.set :root,     'spec/fixtures'
  config.set :sitename, 'a tributary site'
end

run Tributary::App
