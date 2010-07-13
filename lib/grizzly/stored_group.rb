require File.expand_path(File.dirname(__FILE__) + '/storage')

module Grizzly
  class StoredGroup
      def method_missing(method, *args)
        Grizzly::Storage.new(:group, method).set
      end
  end
end