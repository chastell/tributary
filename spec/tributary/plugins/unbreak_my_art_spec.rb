# encoding: UTF-8

module Tributary describe Plugins::UnbreakMyArt do

  def unbreak string
    Plugins::UnbreakMyArt.new.handle(mock Item, body: string).body
  end

  describe '#handle' do

    it 'prevents line wrapping after single-letter words' do
      unbreak('give me a break').should == 'give me a break'
    end

    it 'prevents line wrapping after line-starting single-letter words' do
      unbreak('a fish!').should          == 'a fish!'
      unbreak("this is\na fish!").should == "this is\na fish!"
    end

  end

end end
