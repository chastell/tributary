module Tributary class Stream

  def self.pick_item path
    Item.new Dir["#{@root}/*/#{path}.md"].first
  end

  def self.root= root
    @root = root
  end

end end
