require File.expand_path(File.dirname(__FILE__) + '/storage')

module Grizzly
    class StoredPermission
      def method_missing(method, *args)
        # If the key matching user id is not found should assign and store all the permissions/groups in redis
        raise Grizzly::PermissionNotDefinedButSetAsDefault unless Grizzly::Permissions::Base.store[method]
        Grizzly::Storage.new(:permission, method).set        
      end
    end
end