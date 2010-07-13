require 'active_record'

class UserPermission < ActiveRecord::Base; end
class UserGroup < ActiveRecord::Base; end

module Grizzly
  module ActiveRecordExtensions
    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def permissions
        ::UserPermission.find_all_by_user_id(id)
      end
      
      def can?(permission)
        raise Grizzly::PermissionNotDefined unless Grizzly::Permissions::Base.store[permission]
        ::UserPermission.find_by_permission_name_and_user_id(:first, permission.to_s, id)
        true
      end
      
      def member_of?(group)
        groups_from_db = ::UserGroup.find_by_group_name_and_user_id(group.to_s, id)
        "looking for specific group in database"
        return true if groups_from_db
        return false unless Grizzly::Groups::Base.store[group]
        true
      end
      
    end
    
    module ClassMethods
      
      def acts_as_grizzly
      end
      
      def owner(authorization_subject)
        # Return owner
      end
      
      def default(kind)
        case kind
        when :permissions
          # Permissions
          include Grizzly::Permissions
          yield(Grizzly::StoredPermission.new)
        when :groups
          # Groups
          include Grizzly::Groups
          yield(Grizzly::StoredGroup.new)
        end
      end
    end
  end
end