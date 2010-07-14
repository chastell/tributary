module Tributary describe App do

  include Rack::Test::Methods

  def app
    App
  end

  it 'renders index' do
    get '/'
    last_response.should be_ok
  end

end end
