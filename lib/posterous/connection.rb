module Posterous
  class Connection
    
    # Typhoeus Defaults
    include Typhoeus
    remote_defaults :base_uri   => Posterous.base_uri,
                    :on_failure => lambda { | response | raise "Request failed with code: #{response.code}" },
                    :headers    => {
                      :Authorization => "Basic #{Posterous.encoded_credentials}"
                    }
    
    # Some twisted injects to conform the ugly XML into pretty 
    # little objects. Returns and Array of the current subclass
    def self.parse_nodes response
      self.nodes_for( response ).inject [] do | site_array, site_node |
        site_array << site_node.children.inject( self.new ) do | site, child |  
          returning site do
            site.send "#{child.name.to_sym}=", child.text if site.respond_to? "#{child.name.to_sym}=" 
          end
        end
      end
    end
    
    # Extract the nodes for inheriting class by
    # reflecting on the current class name. This pattern
    # works across the entire API.
    def self.nodes_for response
      Nokogiri::HTML( response ).css( self.class_name.downcase )
    end
    
    # Split off the Namespace
    def self.class_name
      @class_name ||= self.to_s.split("::").last
    end
    
  end
end