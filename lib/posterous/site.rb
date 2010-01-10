module Posterous
  
  # Site (http://posterous.com/api/getsites)
  # Usage:
  # Posterous::Site.all
  # Returns a collection of the authenticated user's Sites
  class Site < Connection
    
    attr_accessor         *SITE_ATTRS
    define_remote_method  :all, :path => '/getsites', :on_success => lambda { | response | parse_nodes response.body }
    
  end
  
end