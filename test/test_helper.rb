%w{rubygems test/unit shoulda}.each { |lib| require lib }
require File.expand_path(File.dirname(__FILE__) + '/../lib/posterous')


class Test::Unit::TestCase
  def teardown

  end
  
  def inherited(base)
    base.define_method teardown do 
      super
    end
  end
end
