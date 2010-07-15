# encoding: UTF-8

module Tributary describe Item do

  before :all do
    @about   = Item.new 'spec/fixtures/page/about.md'
    @welcome = Item.new 'spec/fixtures/article/welcome.md'
  end

  context '#body' do

    it 'returns the given Item’s markdown-processed body' do
      @about.body.should   == "<p>tributary <em>about</em> page</p>\n\n<p>about this tributary install</p>\n"
      @welcome.body.should == "<p>tributary <em>welcome</em> article</p>\n"
    end

  end

  context '#date' do

    it 'returns the given Item’s parsed date' do
      @about.date.should   == nil
      @welcome.date.should == Date.new(2010, 7, 15)
    end

  end

  context '#title' do

    it 'returns the given Item’s YAML-specified title' do
      @about.title.should   == 'about tributary'
      @welcome.title.should == 'welcome to tributary'
    end

  end

  context '#view' do

    it 'returns the given Item’s view' do
      @about.view.should   == :page
      @welcome.view.should == :article
    end

  end

end end
