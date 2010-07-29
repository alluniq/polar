require 'action_controller'

module Polar #nodoc
  module ActionControllerExtensions

    def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          before_filter "authorized?"
        end
    end

    module InstanceMethods
      def authorized?
        begin
          name = "#{controller_path.gsub('/', '__')}_controller".to_sym
          if Polar::Permissions.for_controller.has_key?(name)
            perm_info = Polar::Permissions.for_controller[name]
            action = perm_info.has_key?(action_name.to_sym) ? action_name.to_sym : :all
            user = current_user
            if perm_info[:action].present?
              perm_info[action][:deny].each do |deny_perm|
                raise Polar::AuthorizationFailureNoUser if user.nil?
                raise Polar::AuthorizationFailureDenyPermission if user.can?(deny_perm)
              end
              perm_info[action][:allow].each do |allow_perm|
                raise Polar::AuthorizationFailureNoUser if user.nil?
                raise Polar::AuthorizationFailureMissedPermission unless user.can?(allow_perm)
              end
            end
          end
        rescue Polar::AuthorizationFailureNoUser
          logger.debug "=> No valid User found"
          redirect_to root_path
        rescue Polar::AuthorizationFailureDenyPermission
          logger.debug "=> User #{current_user.id} has :deny permission on this action"
          redirect_to root_path
        rescue Polar::AuthorizationFailureMissedPermission
          logger.debug "=> Authorization Failure :: User #{current_user.id} doesn't have required permissions"
          redirect_to root_path
        end
        return true
      end
    end

    module ClassMethods

    end
  end
end

if defined? ActionController::Base
  ActionController::Base.send(:include, Polar::ActionControllerExtensions)
end