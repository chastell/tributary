module Tributary module Plugins module Mnml

  def body
    super.tr 'aeiouy', ''
  end

  def title
    super.tr 'aeiouy', ''
  end

end end end
