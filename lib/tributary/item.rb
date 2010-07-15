module Tributary class Item < OpenStruct

  def initialize file
    @file = file
    yaml, @body = File.read(@file).split "\n\n", 2
    super YAML.load yaml
  end

  def body
    Kramdown::Document.new(@body).to_html
  end

  def date
    case @table[:date]
    when Date   then @table[:date].to_time
    when String then Time.parse @table[:date]
    end
  end

  def path
    File.basename @file, '.md'
  end

  def published?
    date and date < Time.now
  end

  def view
    @file.split('/').reverse[1].to_sym
  end

end end
