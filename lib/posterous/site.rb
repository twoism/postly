module Posterous

  class Site < Connection
    
    attr_accessor *SITE_ATTRS
    
    # URL
    # http://posterous.com/api/getsites
    # Fields
    # None
    def self.find
      conform get "/getsites", defaults
    end
    
  end
end