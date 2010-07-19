module Tributary class Stream

  def initialize root
    @items      = Dir["#{root}/*/*.md"].map { |file| Item.new file }
    @previous   = Hash[recent.each_cons(2).to_a]
    @subsequent = Hash[recent.reverse.each_cons(2).to_a]
  end

  def pick_item path
    path, lang = path.split '.'
    @items.find { |item| item.path == path and item.lang == lang }
  end

  def previous item
    @previous[item]
  end

  def recent limit = @items.size
    @items.select(&:published?).sort_by(&:date).reverse.take limit
  end

  def subsequent item
    @subsequent[item]
  end

end end
