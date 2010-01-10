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
      conform post "/updatepost", defaults.merge( :query => params, :post_id => post_id )
    end
    
  end
end