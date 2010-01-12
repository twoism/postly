require "test_helper"

class WordPressBlogImporter < Posterous::BlogImporter
  
  def self.entity_map
    { :entry => "item", :body => "encoded", :title => "title" }
  end
  
  def self.process_body item
    CGI.unescapeHTML(item.css("encoded").to_s).gsub(/<encoded>|<\/encoded>|\]\]>/,"")
  end
end


class Posterous::BlogImporterTest < Test::Unit::TestCase
  context "A Importer" do
    setup do
      @dir      = File.dirname(__FILE__) + '/fixtures'
      @wp_xml   = File.open("#{@dir}/wp.xml", 'r')
      
      @imported = WordPressBlogImporter.import @wp_xml.read, Posterous::Site.find.last.id
    end

    should "be an array" do
      assert @imported.is_a? Array
    end
  end
  
end