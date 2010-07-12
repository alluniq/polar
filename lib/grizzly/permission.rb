module Grizzly
    class Permission
      
      def method_missing(method, *args)
        # If the key matching user id is not found should assign and store all the permissions/groups in redis
        Grizzly::Storage.new(:permission, method)        
      end
    end
end