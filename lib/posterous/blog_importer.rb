module Posterous
  class BlogImporter
    
    def self.import xml, site_id 
      @doc   = Nokogiri::HTML xml     
      
      @doc.css( entry_root ).inject([]) do | entries, item |        
        params = { :site_id => site_id }
        (POST_ATTRS - [:id]).each do | attr_name |
          params[attr_name] = case
            when self.respond_to?( callback_for(attr_name) ) then self.send( callback_for(attr_name), item )
            when entity_map.keys.include?( attr_name ) then item.css( entity_map[attr_name] ).text
            else next
          end
        end
        post = create_post( params )
        handle_comments_for( post, item ) if respond_to? :handle_comments_for
        entries << post
      end
    end
    
    def self.callback_for attr_name
      "process_#{attr_name}".to_sym
    end
    
    def self.entry_root
      entity_map[:entry]
    end
    
    def self.create_post params
      post = Posterous::Post.create(params)
      puts "Created: #{params.inspect}"
      params
    end
  end
  
end