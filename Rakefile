require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
 
begin
  require 'jeweler'
  Jeweler::Tasks.new do |g|
    g.name = 'posterous'
    g.summary = %(API Wrapper for posterous.com)
    g.description = %(API Wrapper for posterous.com)
    g.email = 'signalstatic@gmail.com'
    g.homepage = 'http://github.com/twoism/posterous'
    g.authors = %w(twoism)
    g.add_dependency 'nokogiri'
    g.add_dependency 'httparty'
    g.add_dependency 'active_support'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler not available. Install it with: sudo gem install jeweler'
end
 
Rake::TestTask.new do |t|
  t.libs = %w(test)
  t.pattern = 'test/**/*_test.rb'
end
 
task :default => :test