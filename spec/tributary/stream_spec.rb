module Tributary describe Stream do

  before :all do
    @about   = Item.new 'spec/fixtures/page/about.md'
    @battle  = Item.new 'spec/fixtures/article/600.md'
    @unix    = Item.new 'spec/fixtures/article/unix-millennium-bug.md'
    @welcome = Item.new 'spec/fixtures/article/welcome.md'
    @stream  = Stream.new 'spec/fixtures'
  end

  context '#pick_item' do

    it 'returns the relevant Item based on the provided path' do
      @stream.pick_item('about').should   == @about
      @stream.pick_item('welcome').should == @welcome
    end

  end

  context '#recent' do

    it 'returns published Items, newest-first' do
      @stream.recent.should == [@battle, @welcome]
    end

  end

end end
