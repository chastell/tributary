module Tributary class Stream

  def initialize
    @items = Dir["#{App.root}/*/*.md"].map { |file| Item.new file }
  end

  def pick_item path
    path, lang = path.split '.'
    (lang ? @items.select { |item| item.lang == lang } : @items).sort.find { |item| item.path == path }
  end

  def previous item, filter = {}
    recent(nil, filter)[recent(nil, filter).index { |i| i.path == item.path } + 1] rescue nil
  end

  def recent limit = nil, filter = {}
    items_ltd({published?: true}.merge filter).take limit || @items.size
  end

  def subsequent item, filter = {}
    recent(nil, filter).reverse[recent(nil, filter).reverse.index { |i| i.path == item.path } + 1] rescue nil
  end

  private

  def items_ltd filter = {}
    items_ltd = @items.sort
    items_ltd.delete_if { |item| item.lang and not App.lang_limit.include? item.lang } if App.lang_limit and not App.lang_limit.empty?
    filter.each do |method, value|
      items_ltd = items_ltd.select { |item| item.send(method) == value }
    end
    items_ltd.select { |item| item == items_ltd.find { |i| i.path == item.path } }
  end

end end
