module Tributary class Item

  attr_reader :title

  def initialize file
    @file = file
    @title, @body = File.read(@file).split "\n\n"
    @title = @title[7..-1]
  end

  def body
    Kramdown::Document.new(@body).to_html
  end

  def view
    @file.split('/').reverse[1].to_sym
  end

end end
