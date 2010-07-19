module Tributary describe Stream do

  before :all do
    @about   = Item.new 'spec/fixtures/pages/about.md'
    @battle  = Item.new 'spec/fixtures/articles/600.md'
    @bi_en   = Item.new 'spec/fixtures/articles/bilingual.en.md'
    @bi_pl   = Item.new 'spec/fixtures/articles/bilingual.pl.md'
    @unix    = Item.new 'spec/fixtures/articles/unix-millennium-bug.md'
    @welcome = Item.new 'spec/fixtures/articles/welcome.md'
    @stream  = Stream.new
  end

  context '#pick_item' do

    it 'returns the relevant Item based on the provided path' do
      @stream.pick_item('about').should        == @about
      @stream.pick_item('welcome').should      == @welcome
      @stream.pick_item('bilingual.en').should == @bi_en
      @stream.pick_item('bilingual.pl').should == @bi_pl
    end

  end

  context '#previous' do

    it 'returns an Item previous to the given Item' do
      @stream.previous(@battle).should == @welcome
      @stream.previous(@about).should  == nil
    end

  end

  context '#recent' do

    it 'returns published Items, newest-first' do
      @stream.recent.should == [@battle, @welcome]
    end

    it 'returns a limited number of newest Items' do
      @stream.recent(1).should == [@battle]
    end

  end

  context '#subsequent' do

    it 'returns an Item subsequent to the given Item' do
      @stream.subsequent(@welcome).should == @battle
      @stream.subsequent(@about).should   == nil
    end

  end

end end
