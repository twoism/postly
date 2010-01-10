%w{rubygems nokogiri ostruct typhoeus active_support base64}.each { |f| require f }

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

module Posterous
  
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




