require 'rubygems'
require 'typhoeus'
require 'json'

@dir          = File.dirname(__FILE__) + '/fixtures'
@image        = File.open("#{@dir}/cthulhu.png", 'r')

response = Typhoeus::Request.post("http://localhost:9393/", :params => {:image => @image} )



puts response.code