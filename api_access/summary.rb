#! /usr/local/bin/ruby -Ku

class ESummary < EPubmed
  attr_accessor :id
  
  def initialize
    @root_path = 'DocSum'
  end
  
end # class ESummary