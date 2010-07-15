module Tributary class Stream

  def initialize root
    @items    = Dir["#{root}/*/*.md"].map { |file| Item.new file }
    @previous = Hash[recent.each_cons(2).to_a]
  end

  def pick_item path
    @items.find { |item| item.path == path }
  end

  def previous item
    @previous[item]
  end

  def recent
    @items.select(&:published?).sort_by(&:date).reverse
  end

end end
