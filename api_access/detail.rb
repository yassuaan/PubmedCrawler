#! /usr/local/bin/ruby -Ku

class Detail
  attr_reader :id, :detail
  
  def initialize(id)
    @id = id
    
  end
  
  def create_detail
    esummary = ESummary.new
    efetch = EFetch.new
    
    esummary.id = @id
    result = esummary.do
    
    @detail = result.first
  end
  
end