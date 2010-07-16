module Tributary class Stream

  def initialize root
    @items    = Dir["#{root}/*/*.md"].map { |file| Item.new file }
    @next     = Hash[recent.reverse.each_cons(2).to_a]
    @previous = Hash[recent.each_cons(2).to_a]
  end

  def next item
    @next[item]
  end

  def pick_item path
    @items.find { |item| item.path == path }
  end

  def previous item
    @previous[item]
  end

  def recent limit = @items.size
    @items.select(&:published?).sort_by(&:date).reverse.take limit
  end

end end
