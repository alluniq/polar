$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'grizzly'
require 'spec'
require 'spec/autorun'
require 'active_record'

Spec::Runner.configure do |config|
  #EMPTY
end

begin
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
rescue ArgumentError
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
end

ActiveRecord::Base.configurations = true
ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.string    :name
    t.datetime  :created_at    
    t.datetime  :updated_at
  end
end

Grizzly.define :permissions do |gz|
  gz.can_edit_profile do |c|
    c.allow :users_controller, :only => [:edit, :update]
  end
  
  gz.can_add_addresses do |c|
    c.allow :addresses_controller, :only => [:new, :create]
  end
  
end

class User < ActiveRecord::Base
  include Grizzly::ActiveRecordExtensions
  
  default :permissions do |p|
    p.can_edit_profile
    p.can_update_profile
  end
  
  default :groups do |g|
    g.administrators
  end
end