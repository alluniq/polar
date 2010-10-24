# Polar

Polar is a simple, fast and powerful way to manage user permissions/groups. It uses simple DSL to define all the available permissions within a system.

### Installation

Add the following line to your Gemfile and run `bundle install`:

    gem 'validated_fields', :git => 'http://github.com/alluniq/polar.git'

### Example definition

	Polar.define :permissions do |pe|
	  pe.edit_profile do |c|
	    c.allow :users_controller, :only => [:edit, :update]
	  end

	  pe.manage_addresses do |gz|
	    c.allow :addresses_controller
	  end
	end

## Setting default permissions/groups

	class User < ActiveRecord::Base
	
	  default :permissions do |p|
	    p.edit_profile
	    p.manage_addresses
	  end
  
	  default :groups do |g|
	    g.administrators
	  end
	end
	
Below the code definition to accompany the settings from User model. That should resist somewhere in your initializers folder.
	
### Example usage

	@user = User.first
	
	# Check if user has specific permission
	@user.can?(:edit_profile)
	
	# Check if user belongs to specific group
	@user.member_of?(:administrators)
	
	
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