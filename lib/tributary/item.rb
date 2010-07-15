module Tributary class Item < OpenStruct

  def initialize file
    @file = file
    yaml, @body = File.read(@file).split "\n\n", 2
    super YAML.load yaml
  end

  def body
    Kramdown::Document.new(@body).to_html
  end

  def view
    @file.split('/').reverse[1].to_sym
  end

end end
