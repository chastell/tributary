# encoding: UTF-8

module Tributary describe App do

  include Rack::Test::Methods

  def app
    App.configure do |config|
      config.set :author,   'Ary Tribut'
      config.set :root,     'spec/fixtures'
      config.set :sitename, 'a tributary site'
      config.set :url,      'http://tributary.example.net/'
    end
    App
  end

  it 'renders the index view when no path given' do
    get '/'
    last_response.should be_ok
    last_response.body.should include 'a tributary index'
  end

  it 'renders the relevant, path-based view' do
    get '/about'
    last_response.should be_ok
    last_response.body.should include 'a tributary page'
    last_response.body.should include 'tributary <em>about</em> page'

    get '/welcome'
    last_response.should be_ok
    last_response.body.should include 'a tributary article'
    last_response.body.should include 'tributary <em>welcome</em> article'
  end

  it 'sets /’s view to :index' do
    get '/'
    last_response.should be_ok
    last_response.body.should include 'index.css'
  end

  it 'exposes settings to views' do
    get '/'
    last_response.should be_ok
    last_response.body.should include '<title>a tributary site</title>'
  end

  it 'exposes Stream to views' do
    get '/'
    last_response.should be_ok
    last_response.body.should include 'welcome to tributary'

    get '/600'
    last_response.should be_ok
    last_response.body.should include 'welcome to tributary'
  end

  it 'renders the Atom feed' do
    get '/feed.xml'
    last_response.should be_ok
    last_response.headers['Content-Type'].should == 'application/atom+xml'
    last_response.body.should == File.read('spec/fixtures/feed.xml')
  end

  it 'renders the CSS stylesheet' do
    get '/layout.css'
    last_response.should be_ok
    last_response.headers['Content-Type'].should == 'text/css'
    last_response.body.should == File.read('spec/fixtures/layout.css')
  end

  it 'renders per-view CSS stylesheets' do
    get '/pages.css'
    last_response.should be_ok
    last_response.headers['Content-Type'].should == 'text/css'
    last_response.body.should == File.read('spec/fixtures/pages.css')
  end

end end
