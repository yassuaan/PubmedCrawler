require "rubygems"
require "active_record"

# DB接続設定
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "pubmedcrawler"

# テーブルにアクセスするためのクラスを宣言
class Record < ActiveRecord::Base
  attr_accessible :pubmed_id, :auther, :title, :publish
  
end
