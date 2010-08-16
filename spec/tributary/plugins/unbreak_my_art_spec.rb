# encoding: UTF-8

module Tributary describe Plugins::UnbreakMyArt do

  describe '#handle' do

    it 'prevents line wrapping after single-letter words' do
      item = mock Item, body: 'give me a break'
      unbroken = Plugins::UnbreakMyArt.new.handle item
      unbroken.body.should == 'give me a break'
    end

  end

end end
