#! /usr/local/bin/ruby -Ku

dirs = Dir.glob("./api_access/**")

dirs.each{|d|
  require d

}

