require 'uri'
require 'net/http'

class Search < ActiveRecord::Base
  validates_presence_of :query

  def get_tags
    tags_url = "http://www.urbandictionary.com/tags.php?tag=norwegians"
    tags_url = "http://www.urbandictionary.com/define.php?term=Alexus"


    UrbanDictionary::Word.from_url("http://www.urbandictionary.com/tags.php?tag=nice")

  end
end
