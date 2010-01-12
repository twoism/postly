module Posterous
  # Quick and Dirty has_many proxy class.
  # #create is the only methods currently needed in the API.
  # Otherwise this would be a bit more robust.
  class ManyProxy
  
    def initialize proxied, klass
      @klass    = klass
      @proxied  = proxied
    end
    
    def create attrs={}
      @klass.create( attrs.merge( foreign_key => @proxied.id ) )
    end
  
    def foreign_key
      (@proxied.class.to_s.split("::").last.downcase << '_id').to_sym
    end
  
  end
end