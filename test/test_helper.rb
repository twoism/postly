require File.expand_path(File.dirname(__FILE__) + '/../lib/posterous')

sites = Posterous::Site.all

sites.each do |s|
  puts s.inspect
end