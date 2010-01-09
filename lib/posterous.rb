%w{rubygems nokogiri ostruct typhoeus}.each { |f| require f }

module Posterous
  class Connection
    include Typhoeus
  end
  class Post
    attr_accessor :site_id, :title, :body, :autopost
    attr_accessor :private, :date, :tags, :source, :sourceLink
  end
  class PosterousError < StandardError; end
end