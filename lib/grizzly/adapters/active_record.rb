require 'active_record'

class UserPermission < ActiveRecord::Base; end
class UserGroup < ActiveRecord::Base; end

module Grizzly #nodoc
  module ActiveRecordExtensions
    
    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def permissions
        ::UserPermission.find_all_by_user_id(self.id)
      end
      
      def permissions
        ::UserGroup.find_all_by_user_id(self.id)
      end
      
      # Check whenever specific subject has right permission assigned to him
      # either via defaults defined in the model or the database
      def can?(permission)
        check(permission, Grizzly::Permissions, ::UserPermission)
      end
      
      # Check whenever specific subject is a member of a right group
      # either via defaults defined in the model or the database
      def member_of?(group)
        check(group, Grizzly::Groups, ::UserGroup)
      end
      
      protected
      
      def check(group, type, storage)
        unless type.instance.subject_store.include? group
          storage.find_all_by_user_id(self.id).each do |sg|
            type.instance.subject_store << sg.group_name.to_sym
          end  
          return true if type.instance.subject_store.include? group
        else
          return true
        end
        false
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
          yield(Grizzly::DefaultPermissions.instance)
        when :groups
          # Groups
          yield(Grizzly::DefaultGroups.instance)
        end
      end
    end
  end
end

if defined? ActiveRecord::Base
  ActiveRecord::Base.send(:include, Grizzly::ActiveRecordExtensions)
end