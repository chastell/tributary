module Tributary class Stream

  def self.pick_item root, path
    Item.new Dir["#{root}/*/#{path}.md"].first
  end

end end
