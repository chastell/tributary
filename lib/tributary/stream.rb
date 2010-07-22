module Tributary class Stream

  def initialize
    @items      = Dir["#{App.root}/*/*.md"].map { |file| Item.new file }.sort
    @previous   = Hash[recent.each_cons(2).to_a]
    @subsequent = Hash[recent.reverse.each_cons(2).to_a]
  end

  def pick_item path
    path, lang = path.split '.'
    (lang ? @items.select { |item| item.lang == lang } : items_ltd).find { |item| item.path == path }
  end

  def previous item
    @previous[items_ltd.find { |i| i.path == item.path }]
  end

  def recent limit = @items.size
    items_ltd.select(&:published?).take limit
  end

  def subsequent item
    @subsequent[items_ltd.find { |i| i.path == item.path }]
  end

  private

  def items_ltd
    items_ltd = @items.dup
    items_ltd.delete_if { |item| item.lang and not App.lang_limit.include? item.lang } if App.lang_limit and not App.lang_limit.empty?
    items_ltd.select { |item| item == items_ltd.find { |i| i.path == item.path } }
  end

end end
