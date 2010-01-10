module Posterous
  class Blog
    
    def self.import xml, site_id 
      @doc   = Nokogiri::HTML xml     
      @doc.css( entity_map[:entry] ).inject([]) do | entries, item |        
        params = { :site_id => site_id }
        
        (POST_ATTRS - [:id]).each do | attr_name |
          params[attr_name] = case
            when self.respond_to?( "process_#{attr_name}".to_sym ) then self.send( "process_#{attr_name}".to_sym, item )
            when entity_map.keys.include?( attr_name ) then item.css( entity_map[attr_name] ).text
            else next
          end
        end
        
        entries << create_post
      end
    end
    
    def self.create_post params
      post = Posterous::Post.create(params)
      puts "Created: #{post.inspect}"
      post
    end
  end
  
end