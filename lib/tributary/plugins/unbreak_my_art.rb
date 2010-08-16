# encoding: UTF-8

module Tributary module Plugins class UnbreakMyArt

  def handle item
    unbroken = SimpleDelegator.new item
    def unbroken.body
      Plugins::UnbreakMyArt.unbreak super
    end
    def unbroken.title
      Plugins::UnbreakMyArt.unbreak super
    end
    unbroken
  end

  private

  def self.unbreak string
    string.gsub /((^|[^\p{L}<])\p{L}\p{P}?) /, '\1 '
  end

end end end
