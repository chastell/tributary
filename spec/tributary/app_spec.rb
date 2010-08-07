# encoding: UTF-8

module Tributary describe App do

  include Rack::Test::Methods

  def app
    App
  end

  before :all do
    App.configure do |config|
      config.set :author,   'Ary Tribut'
      config.set :root,     'spec/site'
      config.set :sitename, 'a tributary site'
    end
  end

  context 'rendering content' do

    it 'renders the index view when no path given' do
      get '/'
      last_response.should be_ok
      last_response.body.should include 'a tributary index'
    end

    it 'renders the given view’s index' do
      get '/articles'
      last_response.should be_ok
      last_response.body.should     include 'welcome to tributary'
      last_response.body.should_not include 'a…'
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

    it 'returns HTTP 404 Not Found on missing items and renders the error template' do
      get '/foo'
      last_response.should_not be_ok
      last_response.status.should == 404
      last_response.body.should include 'Quoth the Server'
    end

    it 'returns HTTP 404 Not Found on missing feeds and does not return the error template' do
      get '/foo.xml'
      last_response.should_not be_ok
      last_response.status.should == 404
      last_response.body.should be_empty
    end

  end

  context 'view settings' do

    it 'sets @item.path in the views’ indices' do
      get '/articles'
      last_response.should be_ok
      last_response.body.should include '<title>a tributary site: articles</title>'
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
      last_response.body.should include 'bilinguality'
    end

  end

  context 'feeds' do

    it 'renders the Atom feed' do
      get '/index.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.xml')
    end

    it 'renders per-locale Atom feeds' do
      get '/index.en.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.en.xml')

      get '/index.pl.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.pl.xml')
    end

    it 'renders lang_limit-ed Atom feeds' do
      get '/index.en.en.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.en.en.xml')

      get '/index.pl.pl.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.pl.pl.xml')

      get '/index.en.en+pl.xml'
      last_response.should be_ok
      last_response.headers['Content-Type'].should == 'application/atom+xml'
      last_response.body.should == File.read('spec/fixtures/index.en.en+pl.xml')
    end

  end

  context 'stylesheets' do

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

  end

  context 'localisation and multilinguality' do

    it 'defaults to nil locale and lang_limit' do
      App.locale.should     == nil
      App.lang_limit.should == nil
    end

    it 'sets the right App settings and redirects properly' do
      get '/set?locale=pl', {}, 'HTTP_REFERER' => '/bilingual'
      last_response.location.should == '/bilingual'
      follow_redirect!
      App.locale.should == 'pl'
      last_response.should be_ok
      last_response.body.should include '<title>dwujęzyczność</title>'

      get '/set?lang_limit=pl'
      follow_redirect!
      App.lang_limit.should == ['pl']
      last_response.should be_ok
      last_response.body.should_not include '600th anniversary (English)'

      get '/set?locale'
      follow_redirect!
      App.locale.should == nil

      get '/set?lang_limit'
      follow_redirect!
      App.lang_limit.should == nil
    end

    it 'localises the output based on locale (defaulting to English)' do
      get '/set?locale=pl'
      get '/bilingual'
      last_response.should be_ok
      last_response.body.should include 'opublikowany 15 lipca 2010'

      get '/set?locale=en'
      get '/bilingual'
      last_response.should be_ok
      last_response.body.should include 'published 15th of July, 2010'

      get '/set?locale'
      get '/bilingual'
      last_response.should be_ok
      last_response.body.should include 'published 15th of July, 2010'
    end

    it 'sets the right value for the <html> element’s lang attribute' do
      get '/set?locale=en'
      get '/'
      last_response.should be_ok
      last_response.body.should include "<html lang='en'>"

      get '/set?locale=pl'
      get '/'
      last_response.should be_ok
      last_response.body.should include "<html lang='pl'>"

      get '/set?locale'
      get '/'
      last_response.should be_ok
      last_response.body.should include "<html lang='en'>"

      get '/set?locale=en'
      get '/bilingual.pl'
      last_response.should be_ok
      last_response.body.should include "<html lang='pl'>"
    end

  end

end end
