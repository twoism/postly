%w{rubygems test/unit shoulda cgi}.each { |lib| require lib }

require File.expand_path(File.dirname(__FILE__) + '/../lib/posterous')

class Test::Unit::TestCase
  def teardown; end
  
  def inherited base 
    base.define_method teardown { super }
  end
end

# @dir    = File.dirname(__FILE__) + '/fixtures'
# @wp_xml = File.open("#{@dir}/wp.xml", 'r')
# 
# class WordPressBlog < Posterous::Blog
#   
#   def self.entity_map
#     { :entry => "item", :body => "encoded", :title => "title" }
#   end
#   
#   def self.process_body item
#     CGI.unescapeHTML(item.css("encoded").to_s).gsub(/<encoded>|<\/encoded>|\]\]>/,"")
#   end
# end
# 
# WordPressBlog.import @wp_xml.read, Posterous::Site.find.last.id

# site  = Posterous::Site.find.last
# doc   = Nokogiri::HTML @wp_xml.read
# 
# doc.css("item").each do |item|
#   item.css("encoded img").each { |img| img["class"] = "posterous_download_image" }
#   title = item.css("title").text
#   body  = item.css("encoded").to_s
#   params = {
#     :site_id => site.id,
#     :title   => title,
#     :body    => CGI.unescapeHTML(body).gsub(/<encoded>|<\/encoded>|\]\]>/,"")
#   }
#   post = Posterous::Post.create(params)
#   puts post.inspect
# end

# posterous_download_image
# http://farm3.static.flickr.com/2407/2243020634_9508a65fe3.jpg

# my_sites = Posterous::Site.find
# post  = Posterous::Post.create(:site_id => my_sites.last.id, :title => "New API Post", :body => "Post body")
# puts post.inspect
#puts Posterous::Post.update(post.id, :title => "New Title", :body => "New Body").inspect

