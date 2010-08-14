# encoding: UTF-8

module Tributary describe Plugins::Mnml do

  context '#handle' do

    it 'minimalises the given Item’s title and body' do
      item = mock Item, :body => 'a wonderful body', :title => 'an interesting title'
      mnml = Plugins::Mnml.new.handle item
      mnml.body.should  == ' wndrfl bd'
      mnml.title.should == 'n ntrstng ttl'
    end

  end

end end
