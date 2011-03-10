# encoding: UTF-8

module Tributary module Plugins module UnbreakMyArt

  def body
    unbreak super
  end

  def title
    unbreak super
  end

  private

  def unbreak string
    string.gsub /((^|[^\p{L}<])\p{L}\p{P}?) /, '\1 '
  end

end end end
