module Tributary describe Stream do

  before :all do
    Stream.root = 'spec/fixtures'
  end

  context '.pick_item' do

    it 'returns the relevant Item based on the provided path' do
      Item.should_receive(:new).with 'spec/fixtures/page/about.md'
      Stream.pick_item 'about'
      Item.should_receive(:new).with 'spec/fixtures/article/welcome.md'
      Stream.pick_item 'welcome'
    end

  end

end end
