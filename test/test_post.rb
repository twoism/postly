require "test_helper"

include Postly

class Postly::PostTest < Test::Unit::TestCase
  context "Postly::Post" do
    
    setup do
      @params = {
        :site_id => 85691,
        :title   => "New from API",
        :body    => 'Sample Body with an <img src="http://farm3.static.flickr.com/2407/2243020634_9508a65fe3.jpg"> inline.'
      }
    end
    
    [:site_id, :title, :body, :autopost, :private,
    :date, :tags, :source, :sourceLink, :id].each do |method|
        should "respond to #{method}" do
          assert Post.new.respond_to? method
        end
    end
    
    context "#create" do
      setup do
        Post.stubs(:create).with(@params).returns(Post.new)
        @post = Post.create(@params)
      end

      should "return a post" do
        assert @post.is_a? Post
      end
  
      should "add posterous_download_image class to images" do
        assert_contains Post.add_download_class(@params[:body]) , /posterous_download_image/
      end
  
    end
    
  end
end