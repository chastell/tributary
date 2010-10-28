module Tributary class App < Sinatra::Base

  register Sinatra::R18n

  use Rack::Session::Cookie, expire_after: 60 * 60 * 24 * 365 * 7

  def self.configure *args, &block
    set :cache?,     production?
    set :lang_limit, nil
    set :locale,     nil
    set :plugins,    []
    set :user_prefs, [:lang_limit, :locale]
    super
    set :stream,     cache? ? Tributary::Stream.new : nil
  end

  before do
    Tributary::App.locale     = session[:locale]
    Tributary::App.lang_limit = session[:lang_limit] && session[:lang_limit].split
    @stream = Tributary::App.stream || Tributary::Stream.new
  end

  get '/' do
    @item = OpenStruct.new type: :index
    haml @item.type
  end

  get '/set' do
    params.each { |key, value| session[key.to_sym] = value if App.user_prefs.map(&:to_s).include? key }
    redirect request.referer
  end

  get '/:feed.xml' do |feed|
    content_type 'application/atom+xml'
    feed, App.locale, lang_limit = feed.split '.'
    App.lang_limit = lang_limit.split if lang_limit
    File.exists?("#{App.views}/#{feed}.xml.haml") ? haml("#{feed}.xml".to_sym, layout: false) : 404
  end

  get '/:style.css' do |style|
    content_type 'text/css'
    File.exists?("#{App.views}/#{style}.sass") ? sass(style.to_sym) : 404
  end

  get '/:path' do |path|
    if @stream.types.map(&:to_s).include? path
      @item = OpenStruct.new path: path, type: "#{path}.index".to_sym
    else
      @item = @stream.pick_item path
    end
    @item ? haml(@item.type) : 404
  end

  error 400...600 do
    if response.content_type == 'text/html'
      @item = OpenStruct.new type: :error
      haml @item.type
    end
  end

end end
