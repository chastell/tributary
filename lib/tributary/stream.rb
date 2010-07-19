module Tributary class Stream

  def initialize
    @items      = Dir["#{App.root}/*/*.md"].map { |file| Item.new file }.select { |item| item.lang == App.lang or item.lang.nil? }
    @previous   = Hash[recent.each_cons(2).to_a]
    @subsequent = Hash[recent.reverse.each_cons(2).to_a]
  end

  def pick_item path
    path, lang = path.split '.'
    if lang
      Item.new Dir["#{App.root}/*/#{path}.#{lang}.md"].first
    else
      @items.find { |item| item.path == path }
    end
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
