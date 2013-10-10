require "rubygems"
require "active_record"

# DB接続設定
#ActiveRecord::Base.establish_connection :adapter => "sqlite3",
#                                        :database => "pubmedcrawler"
config = YAML.load_file('./database.yml')
ActiveRecord::Base.establish_connection(config["db"]["development"])


# テーブルにアクセスするためのクラスを宣言
class Record < ActiveRecord::Base
  attr_accessible :pubmed_id, :author, :title, :publish
  
  def self.create_with_record(data)
    create! do |record|
      record.pubmed_id = data[:pubmed_id]
      record.author = data[:author]
      record.title = data[:title]
      record.publish = data[:publish]
      
    end
    
  end
  
  def self.find_first_by_auth_conditions(pid)
    conditions = pid.dup

    where(:pubmed_id => conditions).first
  
  end
  
end
