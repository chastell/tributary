# encoding: UTF-8

module Tributary describe Item do

  before :all do
    @about   = Item.new 'spec/fixtures/page/about.md'
    @welcome = Item.new 'spec/fixtures/article/welcome.md'
  end

  context '#body' do

    it 'returns the given Item’s markdown-processed body' do
      @about.body.should   == "<p>tributary <em>about</em> page</p>\n"
      @welcome.body.should == "<p>tributary <em>welcome</em> article</p>\n"
    end

  end

  context '#view' do

    it 'returns the given Item’s view' do
      @about.view.should   == :page
      @welcome.view.should == :article
    end

  end

end end
