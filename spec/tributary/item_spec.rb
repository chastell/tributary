# encoding: UTF-8

module Tributary describe Item do

  before :all do
    @about   = Item.new 'spec/fixtures/pages/about.md'
    @battle  = Item.new 'spec/fixtures/articles/600.md'
    @beep    = Item.new 'spec/fixtures/beeps/beep.md'
    @bi_en   = Item.new 'spec/fixtures/articles/bilingual.en.md'
    @bi_pl   = Item.new 'spec/fixtures/articles/bilingual.pl.md'
    @unix    = Item.new 'spec/fixtures/articles/unix-millennium-bug.md'
    @welcome = Item.new 'spec/fixtures/articles/welcome.md'
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
      @unix.date.should    == Time.utc(2038, 1, 19,  3, 14, 07)
      @welcome.date.should == Time.mktime(2010, 7, 15)
    end

  end

  context '#eql?' do

    it 'returns predicate for sane use of Items as Hash keys' do
      @about.should be_eql Item.new('spec/fixtures/pages/about.md')
    end

  end

  context '#hash' do

    it 'returns static value for sane use of Items as Hash keys' do
      @about.hash.should == Item.new('spec/fixtures/pages/about.md').hash
    end

  end

  context '#lang' do

    it 'returns the Item’s language (if defined)' do
      @about.lang.should == nil
      @bi_en.lang.should == 'en'
      @bi_pl.lang.should == 'pl'
    end

  end

  context '#path' do

    it 'returns the given Item’s path' do
      @about.path.should  == 'about'
      @battle.path.should == '600'
      @bi_en.path.should  == 'bilingual'
      @bi_pl.path.should  == 'bilingual'
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

    it 'returns elided body if the YAML-specified title is missing' do
      @beep.title.should == 'beep…'
    end

  end

  context '#view' do

    it 'returns the given Item’s view' do
      @about.view.should   == :pages
      @welcome.view.should == :articles
    end

  end

end end
