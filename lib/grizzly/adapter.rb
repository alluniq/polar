require File.expand_path(File.dirname(__FILE__) + '/stored_permission')
require File.expand_path(File.dirname(__FILE__) + '/stored_group')
require File.expand_path(File.dirname(__FILE__) + '/adapter/active_record')

if defined? ActiveRecord::Base
  ActiveRecord::Base.send(:include, Grizzly::ActiveRecordExtensions)
end