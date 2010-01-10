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
    end
    
    [:id,:name,:hostname,:url,:private,
      :primary,:commentsenabled,:num_posts].each do |method|
        should "respond to #{method}" do
          assert Site.new.respond_to? method
        end
    end

  end
end