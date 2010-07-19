module Tributary class App < Sinatra::Base

  before do
    @stream = Tributary::Stream.new
  end

  get '/' do
    @item = OpenStruct.new view: :index
    haml @item.view
  end

  get '/feed.xml' do
    content_type 'application/atom+xml'
    haml :feed, layout: false
  end

  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

  get '/:path' do |path|
    @item = @stream.pick_item path
    haml @item.view
  end

end end
