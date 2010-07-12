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
          yield(Grizzly::Permissions::Base.new)
        when :groups
          # Groups
          include Grizzly::Groups
          yield(Grizzly::Groups::Base.new)
        end
      end
    end
  end
end