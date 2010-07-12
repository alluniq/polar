require File.expand_path(File.dirname(__FILE__) + '/permissions')
require File.expand_path(File.dirname(__FILE__) + '/groups')
require File.expand_path(File.dirname(__FILE__) + '/adapter/active_record')

if defined? ActiveRecord::Base
  ActiveRecord::Base.send(:include, Grizzly::ActiveRecordExtensions)
end