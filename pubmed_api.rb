#! /usr/local/bin/ruby -Ku

require 'rexml/document'
require 'open-uri'
require 'rubygems'
require './api_access/reqlist.rb'

require './model/record.rb'

class PubmedCrawler
  RET_MAX = 20
  attr_accessor :keyword ,:retmax
  attr_accessor :esearch
  
  def initialize(keyword=nil)
    @keyword = keyword if keyword
    @retmax = RET_MAX
    @esearch = ESearch.new
#    @esummary = ESummary.new
#    @efetch = EFetch.new
    @esearch.retstart = 0
    
  end
  
  def do
    @esearch.keyword = @keyword
    @esearch.retmax = @retmax
    idlist = @esearch.do_output_idlists
    details = []

    idlist.each{|id| details << Detail.new(id) }
    
    return details
  end
  
  def structure_from_detail(result)
      result.create_detail
      res = result.detail
      authors = []
      tmp = [res[:AuthorList]].flatten # return hash when only one author (want to return array)
      tmp.each{|a| authors << a[:Author] }
      publish = res[:PubDate]
      if publish == nil
        publish = 'no information'
      end  
#      Article.create({:pubmed_id => res[:Id], :title => res[:Title], :author => authors.join(', '), :publish => res[:EPubDate]}) 
      response = {:pubmed_id => res[:Id], :title => res[:Title], :author => authors.join(', '), :publish => publish}
    
    return response
  end
  
  def crawl
    while 1
      datalist = self.do
      
      @esearch.retstart += RET_MAX
      
      datalist.each{|d|
        res = self.structure_from_detail(d)
        
        record = Record.new(:pubmed_id => res[:pubmed_id], :title => res[:title], :author => res[:auther], :publish => res[:publish])
        record.save
        
        #puts res
        #puts '++++++++++++'
      }

      #puts '--------'
      
    end
    
  end
  
end

test = PubmedCrawler.new
test.keyword = 'cancer'

res = test.crawl
#puts res