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

  end
end