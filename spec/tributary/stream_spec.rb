# encoding: UTF-8

module Tributary describe Stream do

  before :all do
    @about   = Item.new 'spec/fixtures/pages/about.md'
    @battle  = Item.new 'spec/fixtures/articles/600.md'
    @bi_en   = Item.new 'spec/fixtures/articles/bilingual.en.md'
    @bi_pl   = Item.new 'spec/fixtures/articles/bilingual.pl.md'
    @unix    = Item.new 'spec/fixtures/articles/unix-millennium-bug.en.md'
    @welcome = Item.new 'spec/fixtures/articles/welcome.md'
  end

  before :each do
    App.locale     = nil
    App.lang_limit = nil
    @stream = Stream.new
  end

  context '#pick_item' do

    it 'returns the relevant Item based on the provided path' do
      @stream.pick_item('about').should        == @about
      @stream.pick_item('welcome').should      == @welcome
      @stream.pick_item('bilingual.en').should == @bi_en
      @stream.pick_item('bilingual.pl').should == @bi_pl
    end

    it 'returns the first language version of an Item (if no Items match App.locale)' do
      @stream.pick_item('bilingual').should == @bi_en
    end

    it 'returns an Item even if it’s outside of current App.lang_limit' do
      App.lang_limit = ['pl']
      @stream.pick_item('unix-millennium-bug').should == @unix
    end

    it 'returns the relevant language version of an Item' do
      App.set :locale, 'en'
      @stream.pick_item('bilingual').should == @bi_en
      @stream.pick_item('about').should     == @about
      App.set :locale, 'pl'
      @stream.pick_item('bilingual').should == @bi_pl
      @stream.pick_item('about').should     == @about
      App.set :locale, nil
    end

  end

  context '#previous' do

    it 'returns an Item previous to the given Item' do
      @stream.previous(@battle).should  == @bi_en
      @stream.previous(@welcome).should == nil
      @stream.previous(@about).should   == nil
    end

    it 'returns an Item previous to the Item with the same path (if the given Item’s lang != App.locale)' do
      @stream.previous(@bi_en).should == @welcome
      @stream.previous(@bi_pl).should == @welcome
    end

  end

  context '#recent' do

    it 'returns published Items, newest-first' do
      @stream.recent.should == [@battle, @bi_en, @welcome]
    end

    it 'returns properly localised Items (if available)' do
      App.locale = 'pl'
      @stream.recent.should == [@battle, @bi_pl, @welcome]
    end

    it 'returns lang_limited Items (if requested)' do
      App.lang_limit = ['en']
      @stream.recent.should == [@battle, @bi_en, @welcome]
      App.lang_limit = ['pl']
      @stream.recent.should == [@battle, @bi_pl, @welcome]
      App.lang_limit = []
      @stream.recent.should == [@battle, @bi_en, @welcome]
    end

    it 'returns a limited number of newest Items' do
      @stream.recent(1).should == [@battle]
    end

  end

  context '#subsequent' do

    it 'returns an Item subsequent to the given Item' do
      @stream.subsequent(@welcome).should == @bi_en
      @stream.subsequent(@battle).should  == nil
      @stream.subsequent(@about).should   == nil
    end

    it 'returns an Item subsequent to the Item with the same path (if the given Item’s lang != App.locale)' do
      @stream.subsequent(@bi_en).should == @battle
      @stream.subsequent(@bi_pl).should == @battle
    end

  end

end end
