require "test_helper"

include Postly

class WordPressBlogImporter < Postly::BlogImporter
  
  def self.entity_map
    { :entry => "item", :body => "encoded", :title => "title" }
  end
  
  def self.process_body item
    CGI.unescapeHTML(item.css("encoded").to_s).gsub(/<encoded>|<\/encoded>|\]\]>/,"")
  end
  
  def self.handle_tags_for node
    node.css("category").css("category").collect \
    { |n| n.attributes["nicename"].text if n.attributes["nicename"].present?  }.compact!.join(",")
  end
  
end


class Postly::BlogImporterTest < Test::Unit::TestCase
  context "A Importer" do
    setup do
      @dir      = File.dirname(__FILE__) + '/fixtures'
      @wp_xml   = File.open("#{@dir}/wp.xml", 'r')
     # @imported = WordPressBlogImporter.import(@wp_xml.read, Site.last.id)
    end

    should "be an array" do
      #assert @imported.is_a? Array
    end
  end
  
end