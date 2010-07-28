# encoding: UTF-8

module Tributary class Item < OpenStruct

  def initialize file
    @file = file
    yaml, @body = File.read(@file).split "\n\n", 2
    super YAML.load yaml
  end

  def <=> other
    case
    when other.date && date then other.date <=> date
    when date               then -1
    when other.date         then 1
    else                         0
    end.nonzero? or
    (other.path <=> path).nonzero? or
    case
    when lang       == App.locale then -1
    when other.lang == App.locale then 1
    when lang.nil?                then -1
    when other.lang.nil?          then 1
    else                               lang <=> other.lang
    end
  end

  def body
    Kramdown::Document.new(@body).to_html
  end

  def date
    case @table[:date]
    when Date   then @table[:date].to_time
    when String then Time.parse @table[:date]
    when Time   then @table[:date]
    end
  end

  alias eql? ==

  def hash
    @file.hash
  end

  def lang
    File.basename(@file, '.md').split('.')[1]
  end

  def path
    File.basename(@file, '.md').split('.').first
  end

  def published?
    date and date < Time.now
  end

  def title
    @table[:title] or @body.scan(/\p{L}+/).first + '…'
  end

  def type
    File.dirname(@file).split('/').last.to_sym
  end

end end
