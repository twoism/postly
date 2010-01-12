module Posterous
  class Post < Connection
    attr_accessor *POST_ATTRS
    
    # URL
    # http://posterous.com/api/newpost
    # Fields
    # "site_id" - Optional. Id of the site to post to. If not supplied, posts to the user's default site
    # "media" - Optional. File data for single file.
    # "media[]" - Optional. File data for multiple file upload. Can be specified multiple times.
    # "title" - Optional. Title of post
    # "body" - Optional. Body of post
    # "autopost" - Optional. 0 or 1.
    # "private" - Optional. 0 or 1.
    # "date" - Optional. In GMT. Any parsable format. Cannot be in the future.
    # "tags" - Optional. Comma separate tags
    # "source" - Optional. The name of your application or website
    # "sourceLink" - Optional. Link to your application or website
    def self.create params={}
      params[:body] = add_download_class params[:body]
      conform post "/newpost", defaults.merge( :query => params )
    end
    
    # URL
    # http://posterous.com/api/updatepost
    # Fields
    # "post_id" - Id of the post to update.
    # "media" - Optional. File data for single file. Will append to post.
    # "media[]" - Optional. File data for multiple file upload. Can be specified multiple times. Will append to post.
    # "title" - Optional. Title of post. Will update post if present.
    # "body" - Optional. Body of post. Will update post if present.
    def self.update post_id, params={}
      params[:post_id] = post_id
      conform post "/updatepost", defaults.merge( :query => params )
    end
    
    # there is probably a better way nodes for the body
    # but this works for now.
    def self.add_download_class html
      doc = Nokogiri::HTML(html)
      doc.css( "img" ).each { |img| img["class"] = "posterous_download_image" }.to_s
      doc.css("body").children.first.to_s
    end
    
    def comments
      ManyProxy.new self
    end
  end
end