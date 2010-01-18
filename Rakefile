require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |g|
    
    g.name        = 'postly'
    g.summary     = %(API Wrapper for posterous.com)
    g.description = %(API Wrapper and IRB console for posterous.com)
    g.email       = 'signalstatic@gmail.com'
    g.homepage    = 'http://github.com/twoism/postly'
    g.authors     = %w(twoism)
    
    g.add_dependency 'nokogiri'
    g.add_dependency 'httparty'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install jeweler'
end
 
Rake::TestTask.new do |t|
  t.libs = %w(lib)
  t.pattern = 'test/*_test.rb'
end
 
task :default => :test