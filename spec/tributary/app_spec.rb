# encoding: UTF-8

module Tributary describe App do

  include Rack::Test::Methods

  def app
    App.configure do |config|
      config.set :root,     'spec/fixtures'
      config.set :sitename, 'a tributary site'
    end
    App
  end

  it 'renders the index view when no path given' do
    get '/'
    last_response.should be_ok
    last_response.body.should include 'a tributary index'
  end

  it 'renders the relevant, path-based view' do
    get '/about'
    last_response.should be_ok
    last_response.body.should include 'a tributary page'
    last_response.body.should include 'tributary <em>about</em> page'

    get '/welcome'
    last_response.should be_ok
    last_response.body.should include 'a tributary article'
    last_response.body.should include 'tributary <em>welcome</em> article'
  end

  it 'exposes settings to views' do
    get '/'
    last_response.should be_ok
    last_response.body.should include '<title>a tributary site</title>'
  end

  it 'exposes Stream to views' do
    get '/'
    last_response.should be_ok
    last_response.body.should include 'welcome to tributary'

    get '/600'
    last_response.should be_ok
    last_response.body.should include 'welcome to tributary'
  end

end end
