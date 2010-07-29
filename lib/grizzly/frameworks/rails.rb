require 'action_controller'

module Grizzly #nodoc
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
          if Grizzly::Permissions.for_controller.has_key?(name)
            perm_info = Grizzly::Permissions.for_controller[name]
            action = perm_info.has_key?(action_name.to_sym) ? action_name.to_sym : :all
            user = current_user
            if perm_info[:action].present?
              perm_info[action][:deny].each do |deny_perm|
                raise Grizzly::AuthorizationFailureNoUser if user.nil?
                raise Grizzly::AuthorizationFailureDenyPermission if user.can?(deny_perm)
              end
              perm_info[action][:allow].each do |allow_perm|
                raise Grizzly::AuthorizationFailureNoUser if user.nil?
                raise Grizzly::AuthorizationFailureMissedPermission unless user.can?(allow_perm)
              end
            end
          end
        rescue Grizzly::AuthorizationFailureNoUser
          logger.debug "GRIZZLY makes WRRRRRRRRRRAU! => Authorization Failure :: No valid User found"
          redirect_to root_path
        rescue Grizzly::AuthorizationFailureDenyPermission
          logger.debug "GRIZZLY makes WRRRRRRRRRRAU! => Authorization Failure :: User #{current_user.id} has deny permission"
          redirect_to root_path
        rescue Grizzly::AuthorizationFailureMissedPermission
          logger.debug "GRIZZLY makes WRRRRRRRRRRAU! => Authorization Failure :: User #{current_user.id} hasn't got required permission"
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
  ActionController::Base.send(:include, Grizzly::ActionControllerExtensions)
end