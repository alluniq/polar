require 'active_record'

class UserPermission < ActiveRecord::Base;
  def self.get_for_subject(subject_id)
    find_all_by_user_id(subject_id)
  end
end

class UserGroup < ActiveRecord::Base;
  def self.get_for_subject(subject_id)
    find_all_by_user_id(subject_id)
  end
end

module Polar #nodoc
  module ActiveRecordExtensions
    
    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def permission_object
        UserPermission
      end

      def group_object
        UserGroup
      end

      def permissions
        return @permissions if defined?(@permissions)
        auth = Polar::Permissions.new
        auth.fill_subject_from_external_store(self.id, permission_object, group_object)
        @permissions = auth.subject_store.sort { |a,b| a.to_s <=> b.to_s }
      end
      
      def groups
        return @groups if defined?(@groups)
        auth = Polar::Groups.new
        auth.fill_subject_from_external_store(self.id, group_object)
        @groups = auth.subject_store.sort { |a,b| a.to_s <=> b.to_s }
      end
      
      # Check whenever specific subject has right permission assigned to him
      # either via defaults defined in the model or the database
      def can?(permission)
        raise Polar::PermissionNotDefined unless Polar::Permissions.defined_store.has_key?(permission)
        permissions.include? permission
      end
      
      # Check whenever specific subject is a member of a right group
      # either via defaults defined in the model or the database
      def member_of?(group)
        groups.include? group
      end
      
    end
    
    module ClassMethods
      
      def acts_as_polar
      end
      
      def owner(authorization_subject)
        # Return owner
      end
      
      def default(kind)
        case kind
        when :permissions
          # Permissions
          yield(Polar::DefaultPermissions.instance)
        when :groups
          # Groups
          yield(Polar::DefaultGroups.instance)
        end
      end
    end
  end
end

if defined? ActiveRecord::Base
  ActiveRecord::Base.send(:include, Polar::ActiveRecordExtensions)
end