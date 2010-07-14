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

end end
