module Tributary class Stream

  def self.pick_item root, path
    Item.new Dir["#{root}/*/#{path}.md"].first
  end

  def self.recent root
    Dir["#{root}/*/*.md"].map { |file| Item.new file }.select(&:published?).sort_by(&:date).reverse
  end

end end
