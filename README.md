Grizzly
===============================

Grizzly is a simple, fast and powerful way to manage user permissions/groups. It uses redis as a backend storage mechanism for all your permissions mechanism and simple DSL to define all the available permissions within a system.

Usage example
----------

	class User < ActiveRecord::Base
	
	  default :permissions do |p|
	    p.can_edit_profile
	    p.can_manage_addresses
	  end
  
	  default :groups do |g|
	    g.administrators
	  end
	end
	
Below the code definition to accompany the settings from User model. That should resist somewhere in your initializers folder.
	
Example definition
----------

	Grizzly.define :permissions do |gz|
	  gz.can_edit_profile do |c|
	    c.allow :users_controller, :only => [:edit, :update]
	  end
  
	  gz.can_manage_addresses do |gz|
	    c.allow :addresses_controller
	  end
	end
	
	
## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


### Credits

- Grzegorz Kazulak <grzegorz.kazulak@gmail.com>