# encoding: UTF-8

module Tributary describe Plugins::UnbreakMyArt do

  def unbreak string
    Plugins::UnbreakMyArt.new.handle(mock Item, body: string).body
  end

  describe '#handle' do

    it 'prevents line wrapping after single-letter words' do
      unbreak('give me a break').should == 'give me a break'
    end

  end

end end
