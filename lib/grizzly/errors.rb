module Grizzly #nodoc
  class PermissionNotDefinedButSetAsDefault < StandardError; end
  class PermissionNotDefined < StandardError; end
  class AuthorizationFailureNoUser < StandardError; end
  class AuthorizationFailureDenyPermission < StandardError; end
  class AuthorizationFailureMissedPermission < StandardError; end
end