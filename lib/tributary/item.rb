module Tributary class Item

  def initialize file
    @file = file
  end

  def view
    @file.split('/').reverse[1].to_sym
  end

end end
