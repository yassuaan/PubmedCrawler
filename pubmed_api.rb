#! /usr/local/bin/ruby -Ku

require 'rexml/document'
require 'open-uri'
require 'rubygems'
require './api_access/reqlist.rb'

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
  
  def crawl
    while 1
      datalist = self.do
      
      @esearch.retstart += RET_MAX
      
      buf = datalist.last.create_detail
      p buf
      puts '--------'
      
    end
    
  end
  
end

#test = PubmedCrawler.new
#test.keyword = 'cancer'

#res = test.crawl
#puts res