module Tributary class Stream

  def initialize
    @all_items  = Dir["#{App.root}/*/*.md"].map { |file| Item.new file }.sort
    @items      = Dir["#{App.root}/*/*.md"].map { |file| Item.new file }.sort
    @items.delete_if { |item| item.lang and not App.lang_limit.include? item.lang } if App.lang_limit and not App.lang_limit.empty?
    @items      = @items.select { |item| item == @items.find { |i| i.path == item.path } }
    @previous   = Hash[recent.each_cons(2).to_a]
    @subsequent = Hash[recent.reverse.each_cons(2).to_a]
  end

  def pick_item path
    path, lang = path.split '.'
    (lang ? @all_items.select { |item| item.lang == lang } : @items).find { |item| item.path == path }
  end

  def previous item
    @previous[@items.find { |i| i.path == item.path }]
  end

  def recent limit = @items.size
    @items.select(&:published?).take limit
  end

  def subsequent item
    @subsequent[@items.find { |i| i.path == item.path }]
  end

end end
