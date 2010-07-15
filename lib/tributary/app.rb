module Tributary class App < Sinatra::Base

  before do
    @stream = Tributary::Stream.new settings.root
  end

  get '/' do
    render_item OpenStruct.new view: :index
  end

  get '/:path' do |path|
    render_item @stream.pick_item path
  end

  private

  def render_item item
    haml item.view, locals: {item: item, sitename: settings.sitename}
  end

end end
