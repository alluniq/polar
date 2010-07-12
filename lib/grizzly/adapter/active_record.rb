module Grizzly
  module ActiveRecordExtensions
    def self.included(base)
        base.extend(ClassMethods)
    end
    
    module ClassMethods
      def owner(authorization_subject)
        # Return owner
      end
      
      def default(kind)
        case kind
        when :permissions
          # Permissions
          include Grizzly::Permissions
          yield(Grizzly::Permission.new)
        when :groups
          # Groups
          include Grizzly::Group
          yield(Grizzly::Group::Base.new)
        end
      end
    end
  end
end