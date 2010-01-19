module Postly
  class Connection
    
    include HTTParty
    
    base_uri Postly.base_uri
    
    def initialize attrs={}
      attrs.each_pair {|k,v| send("#{k}=".to_sym, v) if respond_to? "#{k}=".to_sym }
    end
    
    def self.defaults
      { :basic_auth => {:username => Postly.config["username"], 
        :password => Postly.config["password"]} }
    end
    
    # quack! quack!
    def self.conform response
      result = array_or_hash response
       case result
       when Hash
         self.new result
       when Array
         result.collect { |item| self.new item }
       end
    end
    
    def self.array_or_hash response
      response["rsp"][self.class_name.downcase]
    end
    
    # Split off the Namespace
    def self.class_name
      @class_name ||= self.to_s.split("::").last
    end
    
    
    def self.many collection_name
      define_method collection_name do
        ManyProxy.new self, singularized_class_name(collection_name)
      end
    end
    
    def singularized_class_name collection_name
      collection_name.to_s.singularize.camelize.constantize
    end
    
  end
end