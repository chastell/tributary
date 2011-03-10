# encoding: UTF-8

module Tributary describe Plugins::UnbreakMyArt do

  def unbreak string
    file = Tempfile.open('Plugins::UnbreakMyArt') { |f| f << "\n\n#{string}" }
    Item.new(file.path).extend(Plugins::UnbreakMyArt).body[3..-6]
  end

  describe '#body, #title' do

    it 'returns the relevant unbroken part' do
      file = Tempfile.open('Plugins::UnbreakMyArt') { |f| f << "title: about a ninja\n\nand a pirate" }
      item = Item.new(file.path).extend Plugins::UnbreakMyArt
      item.title.should == 'about a ninja'
      item.body.should  == "<p>and a pirate</p>\n"
    end

  end

  describe '#unbreak' do

    it 'prevents line wrapping after single-letter words' do
      unbreak('give me a break').should == 'give me a break'
    end

    it 'prevents line wrapping after line-starting single-letter words' do
      unbreak('a fish!').should          == 'a fish!'
      unbreak("this is\na fish!").should == "this is\na fish!"
    end

    it 'does not alter one-letter HTML tags' do
      unbreak("<a href='http://en.wikipedia.org/wiki/Invisible_Pink_Unicorn'>I want to believe</a>").should == '<a href="http://en.wikipedia.org/wiki/Invisible_Pink_Unicorn">I want to believe</a>'
    end

    it 'allows for optional trailing punctuation' do
      unbreak('I, Clau-Clau-Claudius').should == 'I, Clau-Clau-Claudius'
    end

  end

end end
