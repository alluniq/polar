module Grizzly
  module Permissions
    class Base
      
      def method_missing(method)
        permissions = {}
        permissions[method] = "allow".to_sym
      end
      
    end
  end
end