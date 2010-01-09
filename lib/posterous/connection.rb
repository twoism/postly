module Posterous
  class Connection
    include Typhoeus
    remote_defaults :base_uri   => Posterous.base_uri,
                    :on_failure => lambda {|response| raise "Request failed with code: #{response.code}" },
                    :headers    => {
                      :Authorization => "Basic #{Posterous.encoded_credentials}"
                    }
    
    # Some twisted injects to conform the ugly 
    # XML into pretty little objects.
    def self.parse_nodes response
      class_name = self.to_s.split("::").last
      site_nodes = Nokogiri::HTML(response.body).css(class_name.downcase)
      site_nodes.inject([]) do |site_array,site_node|
        site_array << site_node.children.inject(self.new) do |site,c|
          returning site do
            site.send "#{c.name.to_sym}=", c.text if site.respond_to? "#{c.name.to_sym}=" 
          end
        end
      end
    end
    
  end
end