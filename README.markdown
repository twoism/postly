posterous (gem name is already taken. will change it later.)
---------
API wrapper for the [posterous.com](http://posterous.com/api "Posterous API") API.


###Install & Setup

posterous is hosted on [gemcutter.org](http://gemcutter.org)

    $ gem install posterous

Add `config/posterous.yml` to your project.
 
    username: email
    password: pass  
    
    
###Usage

    require 'posterous'

    my_sites = Posterous::Site.find
    => [#<Posterous::Site:0x1015a8d48 @num_posts="21", @commentsenabled="true",@name="twoism", 
    @private="false", @url="http://twoism.posterous.com", @hostname="twoism", @id="85691", @primary="true">]
      
    my_sites.first.posts.create(:title => "New API Post", :body => "Post body")
    => <Posterous::Post:0x102541f70 @title="New API Post">
      
    post = Posterous::Post.create(:site_id => my_sites.first.id, :title => "New API Post", :body => "Post body")
    => <Posterous::Post:0x102541f70 @title="New API Post">
    
    post.comments.create(:comment => "New Comment", :email => "some@one.com")
    => <Posterous::Comment:0x102541f70 @id=123456>
    
    Posterous::Post.update(post.id, :title => "New Title", :body => "New Body")
    => <Posterous::Post:0x102541f70 @title="New Title">
    
###Blog Importing
Blogs can be imported from any XML data that can be mapped to a Post's attributes. If any element needs special treatment, just implement
a #process_<element_name> method class method on your mapper.

###The Importer Sub-class
    
    class WordPressBlogImporter < Posterous::BlogImporter
      
      # map values from the xml to the post attrs 
      # that you would like to set.
      def self.entity_map
        { :entry => "item", :body => "encoded", :title => "title" }
      end
      
      # any post attr can be pre-processed during import.
      def self.process_body item
        CGI.unescapeHTML(item.css("encoded").to_s).gsub(/<encoded>|<\/encoded>|\]\]>/,"")
      end

      # extract tags from the node if needed
      def self.handle_tags_for node
        node.css("category").css("category").collect \
        { |n| n.attributes["nicename"].text if n.attributes["nicename"].present?  }.compact!.join(",")
      end
      
      # not yet implemented
      def self.handle_comments post, node; end

    end
    
    
    @dir    = File.dirname(__FILE__) + '/fixtures'
    @wp_xml = File.open("#{@dir}/wp.xml", 'r')
    
    WordPressBlogImporter.import @wp_xml.read, Posterous::Site.find.last.id

###License

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


###Credits
c. burnett ( github.com/twoism || twoism.posterous.com )







