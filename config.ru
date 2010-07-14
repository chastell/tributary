require 'lib/tributary'

Tributary::App.configure do |config|
  config.set :root, 'spec/fixtures'
end

run Tributary::App
