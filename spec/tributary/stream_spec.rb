module Tributary describe Stream do

  context '.pick_item' do

    it 'returns the relevant Item based on the provided path' do
      Stream.pick_item('spec/fixtures', 'about').should   == Item.new('spec/fixtures/page/about.md')
      Stream.pick_item('spec/fixtures', 'welcome').should == Item.new('spec/fixtures/article/welcome.md')
    end

  end

  context '.recent' do

    it 'returns published Items, newest-first' do
      Stream.recent('spec/fixtures').should == [
        Item.new('spec/fixtures/article/600.md'),
        Item.new('spec/fixtures/article/welcome.md'),
      ]
    end

  end

end end
