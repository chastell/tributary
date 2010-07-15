module Tributary class Stream

  def pick_item root, path
    Item.new Dir["#{root}/*/#{path}.md"].first
  end

  def recent root
    Dir["#{root}/*/*.md"].map { |file| Item.new file }.select(&:published?).sort_by(&:date).reverse
  end

end end
