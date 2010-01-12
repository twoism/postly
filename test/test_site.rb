require "test_helper"

include Posterous

class Posterous::SiteTest < Test::Unit::TestCase
  context "Posterous::Site" do
    
    setup do
      sites = [Site.new,Site.new]
      Site.expects(:find).returns(sites)
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
    
    context "#all" do
      setup do
        Site.expects(:all).returns(@sites)
        @all = Site.all
      end
      should "eql #find" do
        assert_equal(@sites.count, @all.count)
      end
    end
    #     
    context "#first" do
      setup do
        Site.expects(:first).returns(@sites.first)
        @first = Site.first
      end
      should "eql first site" do
        assert_equal(@sites.first.name, @first.name)
      end
    end
    #     
    context "#last" do
      setup do
        Site.expects(:last).returns(@sites.last)
        @last = Site.last
      end
      should "eql last site" do
        assert_equal(@sites.last.name, @last.name)
      end
    end
    
  end
end