# encoding: UTF-8

module Tributary describe Plugins::Mnml do

  describe '#body, #title' do

    it 'returns the relevant minimalised part' do
      file = Tempfile.open('Plugins::Mnml') { |f| f << "title: an interesting title\n\na wonderful body" }
      item = Item.new(file.path).extend Plugins::Mnml
      item.title.should == 'n ntrstng ttl'
      item.body.should  == "<p> wndrfl bd</p>\n"
    end

  end

end end
