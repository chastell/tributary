module Tributary class App < Sinatra::Base

  before do
    @stream = Tributary::Stream.new settings.root
  end

  get '/' do
    haml :index
  end

  get '/:path' do |path|
    item = @stream.pick_item path
    haml item.view, locals: {item: item}
  end

end end
