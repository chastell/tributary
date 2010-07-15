module Tributary class Item

  def initialize file
    @file = file
  end

  def body
    Kramdown::Document.new(File.read @file).to_html
  end

  def view
    @file.split('/').reverse[1].to_sym
  end

end end
