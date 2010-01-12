require "test_helper"

include Posterous

class Posterous::SiteTest < Test::Unit::TestCase
  context "Posterous::Site" do
    
    setup do
      @sites = Site.find
    end
    
    [:id,:name,:hostname,:url,:private,
      :primary,:commentsenabled,:num_posts].each do |method|
        should "respond to #{method}" do
          assert Site.new.respond_to? method
        end
    end
    
    should "be an array" do
      assert @sites.is_a? Array
    end
    
    should "contain sites" do
      @sites.each { |s| assert s.is_a? Site }
    end
    
    should "respond to create through posts" do
      assert @sites.last.posts.respond_to? :create
    end
    
    should "be a ManyProxy" do
      assert_equal ManyProxy, @sites.last.posts.class
    end
    
    should "gen the correct foreign key" do
      assert_equal( :site_id, @sites.last.posts.foreign_key )
    end

  end
end