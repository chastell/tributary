module Tributary describe Plugins::Dummy do

  context '#handle' do

    it 'returns an unmodified Item' do
      item = mock Item
      Plugins::Dummy.new.handle(item).should equal item
    end

  end

end end
