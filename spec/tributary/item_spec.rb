# encoding: UTF-8

module Tributary describe Item do

  before :all do
    @about   = Item.new 'spec/fixtures/page/about.md'
    @welcome = Item.new 'spec/fixtures/article/welcome.md'
  end

  context '#view' do

    it 'returns the given Item’s view' do
      @about.view.should   == :page
      @welcome.view.should == :article
    end

  end

end end
