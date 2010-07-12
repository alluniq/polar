module Grizzly
  module Group
    class Base
      
      def method_missing(method)
        Grizzly::Storage.new(:group, method)
      end
      
    end
  end
end