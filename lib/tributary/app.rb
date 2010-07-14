module Tributary class App < Sinatra::Base

  get '/' do
    haml :index
  end

  get '/:path' do |path|
    view = case path
           when 'about'   then :page
           when 'welcome' then :article
           end
    haml view
  end

end end
