module Tributary module Plugins class Mnml

  def handle item
    mnml = SimpleDelegator.new item
    def mnml.body
      super.tr 'aeiouy', ''
    end
    def mnml.title
      super.tr 'aeiouy', ''
    end
    mnml
  end

end end end
