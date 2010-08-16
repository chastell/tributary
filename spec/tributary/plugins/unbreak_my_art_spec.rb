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

    it 'does not alter one-letter HTML tags' do
      unbreak("<a href='http://en.wikipedia.org/wiki/Invisible_Pink_Unicorn'>I want to believe</a>").should == "<a href='http://en.wikipedia.org/wiki/Invisible_Pink_Unicorn'>I want to believe</a>"
    end

    it 'allows for optional trailing punctuation' do
      unbreak('I, Clau-Clau-Claudius').should == 'I, Clau-Clau-Claudius'
    end

    it 'unbreaks bodies and titles' do
      unbroken = Plugins::UnbreakMyArt.new.handle mock Item, title: 'about a ninja', body: 'and a pirate'
      unbroken.title.should == 'about a ninja'
      unbroken.body.should  == 'and a pirate'
    end

  end

end end
