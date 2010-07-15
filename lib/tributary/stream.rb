module Tributary class Stream

  def initialize root
    @root = root
  end

  def pick_item path
    Item.new Dir["#{@root}/*/#{path}.md"].first
  end

  def recent
    Dir["#{@root}/*/*.md"].map { |file| Item.new file }.select(&:published?).sort_by(&:date).reverse
  end

end end
