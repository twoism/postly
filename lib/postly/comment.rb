module Postly
  class Comment < Connection
    attr_accessor *COMMENT_ATTRS
  # URL
  # http://postly.com/api/newcomment
  # Fields
  # "post_id" - The post id to comment on
  # "comment" - The comment body
  # "name" - Optional. The name to use
  # "email" - Optional. The email address to use
  # "date" - Optional. In GMT. Any parsable format. Cannot be in the future.
  def self.create params={}
    conform post "/newcomment", defaults.merge( :query => params )
  end
  
  end
end