module Tributary class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/:path' do |path|
    item = Stream.pick_item settings.root, path
    haml item.view, locals: {item: item}
  end

end end
