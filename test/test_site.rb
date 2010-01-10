require "test_helper"

include Posterous

class Posterous::SiteTest < Test::Unit::TestCase
  context "Posterous::Site" do
    setup do
      @site_response = <<XML
      <?xml version="1.0" encoding="UTF-8"?>
      <rsp stat="ok">
        <site>
          <id>85691</id>
          <name>twoism</name>
          <hostname>twoism</hostname>
          <url>http://twoism.posterous.com</url>
          <private>false</private>
          <primary>true</primary>
          <commentsenabled>true</commentsenabled>
          <num_posts>21</num_posts>
        </site>
      </rsp>
XML
      @response = Site.all
    end
    
    [:id,:name,:hostname,:url,:private,
      :primary,:commentsenabled,:num_posts].each do |method|
        should "respond to #{method}" do
          assert Site.new.respond_to? method
        end
    end
    
    context "#all" do
      should "responds to" do
        assert Site.respond_to? :all
      end
    end
    
    context "#class_name" do
      should "eql Site" do
        assert_equal("Site", Site.class_name)
      end
    end
    
    context "#nodes_for" do
      should "eql 1" do
        assert_equal 1, Site.nodes_for(@site_response).count
      end
    end
    
    context "#parse_nodes" do
      setup do
        @parsed = Site.parse_nodes(@site_response)
      end
      
      should "return an array" do
        assert @parsed.is_a? Array
      end
      
      should "have 1 result" do
        assert_equal 1, @parsed.count
      end
      
      context "returned contents" do 
        setup do
          @site = @parsed.first
        end

        should "be Sites" do
          assert @site.is_a? Site
        end
      end
      
    end
  end
end