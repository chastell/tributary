module Tributary class App < Sinatra::Base

  register Sinatra::R18n

  use Rack::Session::Cookie, expire_after: 60 * 60 * 24 * 365 * 7

  def self.configure *args, &block
    set :locale,     nil
    set :lang_limit, nil
    super
  end

  before do
    Tributary::App.locale     = session[:locale]
    Tributary::App.lang_limit = session[:lang_limit] && session[:lang_limit].split
    @stream = Tributary::Stream.new
  end

  get '/' do
    @item = OpenStruct.new view: :index
    haml @item.view
  end

  get '/set' do
    params.each { |key, value| session[key.to_sym] = value }
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
