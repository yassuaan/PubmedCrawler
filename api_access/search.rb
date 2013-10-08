#! /usr/local/bin/ruby -Ku

class ESearch < EPubmed
  attr_accessor :keyword
  attr_accessor :retstart #use next
  attr_accessor :retmax
  attr_accessor :rettype
  attr_accessor :datetype
  attr_accessor :mindate, :maxdate
  
  def initialize(keyword=nil)
    @keyword = keyword if keyword
    @root_path = '!DOCTYPE'
  end
  
  def do_output_idlists(res=nil)
    if res == nil
      res = self.do 
    end
    
    buf = [res.first[:IdList]].flatten
    idlist = []
    buf.each{|ids|
      idlist << ids[:Id]
    }
    return idlist
    
  end
  
end # class ESearch