%w{rubygems nokogiri ostruct active_support httparty base64}.each { |f| require f }

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

module Posterous
  
  SITE_ATTRS = [:name,    :url,   :private, :primary,   :hostname,  :commentsenabled, :num_posts, :id]
  POST_ATTRS = [:site_id, :title, :body,    :autopost,  :private,   :date,            :tags,      :source, :sourceLink, :id]
  
  # defunkt's singleton trick
  extend self
  
  # Base64 Encoding credentials for Basic Auth
  def encoded_credentials  
    @credentials ||= Base64.encode64("#{config['username']}:#{config['password']}")
  end
  
  # Currently looks in the current working directory
  # for config/posterous.yml
  def config
    @config ||= File.open(File.join(Dir.getwd, 'config/posterous.yml'), 'r') { |f| YAML.load(f) }
  end
  
  #
  def base_uri
    @base_uri ||= "http://posterous.com/api"
  end
  
  # Not sure if I need this yet
  class PosterousError < StandardError; end
end

%w{connection post site}.each {|f| require "posterous/#{f}"}




