module Tributary describe Stream do

  before :all do
    Stream.root = 'spec/fixtures'
  end

  context '.pick_item' do

    it 'returns the relevant Item based on the provided path' do
      Stream.pick_item('about').should   == Item.new('spec/fixtures/page/about.md')
      Stream.pick_item('welcome').should == Item.new('spec/fixtures/article/welcome.md')
    end

  end

end end
