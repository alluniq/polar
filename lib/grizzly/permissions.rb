module Grizzly #nodoc
  class DefaultPermissions
    
    # This method is executed whenever a default permission is defined
    # in subject's model
    def method_missing(method, *params)
      Permissions.instance.subject_store << method.to_sym
      self
    end
    
    # Protects from creating more than one instance of this class    
    def self.instance
      @__instance__ ||= new
    end
    
  end
  
  class Permissions
    attr_accessor :defined_permissions_store
    attr_accessor :subject_store
      
    def initialize
      unless @defined_permissions_store
        @defined_permissions_store = []
      end
      
      unless @subject_store
        @subject_store = []
      end
      self
    end
    
    def self.instance
      @__instance__ ||= new
    end  
      
    def self.define(&block)
      self
    end
      
    def self.method_missing(method, &block)
      yield PermissionHash.new(method) if block_given?
    end
      
    def self.defined_store
      unless @defined_permissions_store
        @defined_permissions_store = {}
      end
      @defined_permissions_store
    end    
  end
  
  class PermissionHash < Hash
    
    def initialize(method)
      self[:permission_name] = method.to_sym
    end
    
    def allow(*params)
      self[:access_type] = :allow
      self[:params] = params
      Grizzly::Permissions.defined_store[self[:permission_name]] = self[:params]
    end
    
    def deny(*params)
      
    end
  end
end