module Tributary describe App do

  include Rack::Test::Methods

  def app
    App.configure do |config|
      config.set :root, 'spec/fixtures'
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

end end
