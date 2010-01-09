module Posterous
  class Post
    attr_accessor :site_id, :title, :body, :autopost
    attr_accessor :private, :date, :tags, :source, :sourceLink
  end
end