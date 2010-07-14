module Tributary class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/about' do
    haml :page
  end

end end
