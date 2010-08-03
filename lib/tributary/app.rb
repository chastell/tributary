module Tributary class App < Sinatra::Base

  register Sinatra::R18n

  use Rack::Session::Cookie, expire_after: 60 * 60 * 24 * 365 * 7

  def self.configure *args, &block
    set :cache,      environment == :production
    set :locale,     nil
    set :lang_limit, nil
    super
    set :stream,     Tributary::Stream.new(root)
  end

  before do
    Tributary::App.locale     = session[:locale]
    Tributary::App.lang_limit = session[:lang_limit] && session[:lang_limit].split
    @stream = Tributary::App.cache ? Tributary::App.stream : Tributary::Stream.new
  end

  get '/' do
    @item = OpenStruct.new type: :index
    haml @item.type
  end

  get '/set' do
    params.each { |key, value| session[key.to_sym] = value }
    redirect request.referer
  end

  get '/:feed.xml' do |feed|
    content_type 'application/atom+xml'
    feed, App.locale, lang_limit = feed.split '.'
    App.lang_limit = lang_limit.split if lang_limit
    haml "#{feed}.xml".to_sym, layout: false
  end

  get '/:style.css' do |style|
    content_type 'text/css'
    sass style.to_sym
  end

  get '/:path' do |path|
    if @stream.types.include? path.to_sym
      @item = OpenStruct.new path: path, type: "#{path}.index".to_sym
    else
      @item = @stream.pick_item path
    end
    haml @item.type
  end

end end
