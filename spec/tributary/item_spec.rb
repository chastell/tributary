# encoding: UTF-8

module Tributary describe Item do

  before :all do
    @about   = Item.new 'spec/fixtures/page/about.md'
    @battle  = Item.new 'spec/fixtures/article/600.md'
    @unix    = Item.new 'spec/fixtures/article/unix-millennium-bug.md'
    @welcome = Item.new 'spec/fixtures/article/welcome.md'
  end

  context '#body' do

    it 'returns the given Item’s markdown-processed body' do
      @about.body.should   == "<p>tributary <em>about</em> page</p>\n\n<p>about this tributary install</p>\n"
      @welcome.body.should == "<p>tributary <em>welcome</em> article</p>\n"
    end

  end

  context '#date' do

    it 'returns the given Item’s parsed Time' do
      @about.date.should   == nil
      @battle.date.should  == Time.mktime(2010, 7, 15, 12, 00)
      @welcome.date.should == Time.mktime(2010, 7, 15)
    end

  end

  context '#path' do

    it 'returns the given Item’s path' do
      @about.path.should  == 'about'
      @battle.path.should == '600'
    end

  end

  context '#published?' do

    it 'returns whether the given Item has a date in the past' do
      @about.should_not be_published
      @battle.should    be_published
      @unix.should_not  be_published
      @welcome.should   be_published
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
