# encoding: UTF-8

module Tributary module Plugins class UnbreakMyArt

  def handle item
    unbroken = SimpleDelegator.new item
    def unbroken.body
      super.gsub /((^|[^\p{L}<])\p{L}) /, '\1 '
    end
    unbroken
  end

end end end
