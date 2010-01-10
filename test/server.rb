require "rubygems"
require "sinatra"
require "growler"

post "/" do
  Growler.growl(params.inspect)
  "boo"
end