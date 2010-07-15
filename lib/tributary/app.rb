module Tributary class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/:path' do |path|
    Stream.root = settings.root
    item = Stream.pick_item path
    haml item.view
  end

end end
