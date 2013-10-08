class ESpell < EPubmed
  attr_accessor :keyword
  
  def initialize
    @retmode = 'xml'
    @root_path = '!DOCTYPE'
  end

  
end # class ESpell