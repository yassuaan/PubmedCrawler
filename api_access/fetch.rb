#! /usr/local/bin/ruby -Ku

class EFetch < EPubmed
  attr_accessor :id
  
  def initialize
    @retmode = 'xml'
    @root_path = 'PubmedArticle'
  end
  
  def abst(id)
    @id = id
    self.do
    tmp = @result.first[:MedlineCitation][:Article][:Abstract]
    abst = ''
    case tmp
    when ::Hash
      abst = tmp[:AbstractText]
      
    when ::Array
      tmp.each{|buf|
        abst += buf[:AbstractText]
      }
      
    end
    return abst
    
  end
  
end # class EFetch
