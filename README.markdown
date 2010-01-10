posterous
---------
API wrapper for the [posterous.com](http://posterous.com/api "Posterous APIS") API.

###Install & Setup

posterous is hosted on [gemcutter.org](http://gemcutter.org)

    $ gem install posterous

Add `config/posterous.yml` to your project.

    username: email
    password: pass  

###Usage

    require 'posterous'

    @my_sites = Posterous::Site.all
    
    => [#<Posterous::Site:0x1015a8d48 @num_posts="21", @commentsenabled="true",
     @name="twoism", @private="false", @url="http://twoism.posterous.com",
      @hostname="twoism", @id="85691", @primary="true">]





