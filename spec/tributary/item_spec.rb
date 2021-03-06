# encoding: UTF-8

module Tributary describe Item do

  before :all do
    App.configure {}
    @about     = Item.new 'spec/site/pages/about.md'
    @battle    = Item.new 'spec/site/articles/600.md'
    @battle_en = Item.new 'spec/site/articles/600.en.md'
    @beep      = Item.new 'spec/site/beeps/beep.md'
    @bi_en     = Item.new 'spec/site/articles/bilingual.en.md'
    @bi_pl     = Item.new 'spec/site/articles/bilingual.pl.md'
    @unix      = Item.new 'spec/site/articles/unix-millennium-bug.en.md'
    @welcome   = Item.new 'spec/site/articles/welcome.md'
  end

  describe '#<=>' do

    it 'sorts Items by date, date-less last' do
      [@bi_en, @beep, @welcome, @about, @battle].sort.should == [@battle, @bi_en, @welcome, @beep, @about]
    end

    it 'sorts same-path Items by lang, based on App.locale' do
      App.locale = 'pl'
      [@bi_en, @bi_pl].sort.should      == [@bi_pl, @bi_en]
      [@battle_en, @battle].sort.should == [@battle, @battle_en]
      App.locale = 'en'
      [@bi_pl, @bi_en].sort.should      == [@bi_en, @bi_pl]
      [@battle, @battle_en].sort.should == [@battle_en, @battle]
      App.locale = nil
      [@bi_pl, @bi_en].sort.should      == [@bi_en, @bi_pl]
      [@battle_en, @battle].sort.should == [@battle, @battle_en]
    end

  end

  describe '#body' do

    it 'returns the given Item’s markdown-processed body' do
      @about.body.should   == "<p>tributary <em>about</em> page</p>\n\n<p>about this tributary install</p>\n"
      @welcome.body.should == "<p>tributary <em>welcome</em> article</p>\n"
    end

  end

  describe '#date' do

    it 'returns the given Item’s parsed Time' do
      @about.date.should   == nil
      @battle.date.should  == Time.mktime(2010, 7, 15, 12, 00)
      @unix.date.should    == Time.utc(2038, 1, 19,  3, 14, 07)
      @welcome.date.should == Time.mktime(2010, 7, 15)
    end

  end

  describe '#eql?' do

    it 'returns predicate for sane use of Items as Hash keys' do
      @about.should be_eql Item.new('spec/site/pages/about.md')
    end

  end

  describe '#hash' do

    it 'returns static value for sane use of Items as Hash keys' do
      @about.hash.should == Item.new('spec/site/pages/about.md').hash
    end

  end

  describe '#lang' do

    it 'returns the Item’s language (if defined)' do
      @about.lang.should == nil
      @bi_en.lang.should == 'en'
      @bi_pl.lang.should == 'pl'
    end

  end

  describe '#path' do

    it 'returns the given Item’s path' do
      @about.path.should  == 'about'
      @battle.path.should == '600'
      @bi_en.path.should  == 'bilingual'
      @bi_pl.path.should  == 'bilingual'
    end

  end

  describe '#published?' do

    it 'returns whether the given Item has a date in the past' do
      @about.should_not be_published
      @battle.should    be_published
      @unix.should_not  be_published
      @welcome.should   be_published
    end

  end

  describe '#title' do

    it 'returns the given Item’s YAML-specified title' do
      @about.title.should   == 'about tributary'
      @welcome.title.should == 'welcome to tributary'
    end

    it 'returns elided body if the YAML-specified title is missing' do
      Item.new('spec/site/beeps/beep.md').title.should  == 'beep…'
      Item.new('spec/site/beeps/link.md').title.should  == 'Qué…'
      Item.new('spec/site/beeps/quote.md').title.should == 'An…'
    end

  end

  describe '#type' do

    it 'returns the given Item’s type' do
      @about.type.should   == :pages
      @welcome.type.should == :articles
    end

  end

end end
