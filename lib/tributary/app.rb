module Tributary class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/:path' do |path|
    item = Stream.pick_item path
    haml item.view
  end

end end
