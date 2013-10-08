#! /usr/local/bin/ruby -Ku

require 'rexml/document'
require 'open-uri'
require 'rubygems'

class EPubmed
  P_DATABASE = 'pubmed'
  def do
    @db = P_DATABASE
    @result = nil
    url = create_url
    
    xml = open(url).read 
    
    hash = xml_to_hash(xml, @root_path)
    @result = hash
    return @result
  end

  #about url    
  def create_url
    queri = create_queri
    api = self.class.name.downcase!
    url = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/'+ api + '.fcgi?' + queri
#      puts url
    return url
    
  end
  
  def create_queri
    arry = []
    instance_variables.each { |var|
      k = var.to_s.tr('@','')
      v = instance_variable_get(var)
      if v.class == Array
        v = v.join(',')
      end
      if k == 'keyword'
        k = 'term'
      end
      arry << "%s=%s" % [k,v]
     }
     return arry.join('&')
  end

 
  # about xml
  
  def xml_to_hash(xml, root_name)
    res = []
#      puts xml
    xml.gsub!(/\n/, '')
    xml.gsub!(/\t/, '')
    xml.gsub!(/>\s+</, '><')
    xml.gsub!(/<\?\S*\?>/, '') #to Efetch
    doc = REXML::Document.new(xml)
    doc.root.get_elements(root_name).collect{|ele|
      hash = xml_deep(ele)
      res << hash
    }
    return res
  end
  
#    private
   
  def xml_deep(xml, h=Hash.new)
    if xml.has_elements?
      arr = []
      xml.children.each{|item|
        if h[decide_key(item)]
          arr << h
          h = Hash.new
        end
        h[decide_key(item)] = xml_deep(item)
      }
      if arr.size > 0
        arr << h
        h = arr
      end
    else
      h = xml.text
    end
    return h
  end

  def decide_key(xml)
    if xml.has_attributes?
      xml.attributes.each{|k, v|
        return v.to_sym if attribute_key(k)
      }
    end
    return xml.name.to_sym
  end

  def attribute_key(key)
    return true if key =~ /Name/
    return false
  end

end