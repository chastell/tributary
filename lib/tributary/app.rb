module Tributary class App < Sinatra::Base

  before do
    @stream = Tributary::Stream.new settings.root
  end

  get '/' do
    @item = OpenStruct.new
    haml :index
  end

  get '/feed' do
    response['Content-Type'] = 'application/atom+xml'
    haml :feed, layout: false
  end

  get '/:path' do |path|
    @item = @stream.pick_item path
    haml @item.view
  end

end end
