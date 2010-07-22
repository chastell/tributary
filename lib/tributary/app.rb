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

  get '/:feed.xml' do |feed|
    content_type 'application/atom+xml'
    haml "#{feed}.xml".to_sym, layout: false
  end

  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

  get '/:path' do |path|
    if @stream.views.include? path.to_sym
      @item = OpenStruct.new view: "#{path}.index".to_sym
    else
      @item = @stream.pick_item path
    end
    haml @item.view
  end

end end
