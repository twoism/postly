module Posterous
  class Site < Connection
    attr_accessor :name, :url, :private, :primary, :hostname
    attr_accessor :commentsenabled, :num_posts, :id

    define_remote_method  :all, 
                          :path => '/getsites', 
                          :on_success => lambda {|response| parse_nodes response.body }
    
  end
end