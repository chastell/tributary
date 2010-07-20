module Tributary class App < Sinatra::Base

  def self.configure *args, &block
    set :lang,       nil
    set :lang_limit, nil
    super
  end

  before do
    Tributary::App.lang       = request.cookies['lang']
    Tributary::App.lang_limit = request.cookies['lang_limit'] && request.cookies['lang_limit'].split
    @stream = Tributary::Stream.new
  end

  get '/' do
    @item = OpenStruct.new view: :index
    haml @item.view
  end

  get '/set' do
    params.each do |key, value|
      if value
        response.set_cookie key, value: value, expires: Time.now + 60 * 60 * 24 * 365 * 7
      else
        response.delete_cookie key
      end
    end
    redirect request.referer
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
