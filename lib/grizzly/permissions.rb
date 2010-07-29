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
    attr_accessor :permissions_for_controller

    def initialize(instance_object = false)
      @defined_permissions_store ||= []
      @subject_store ||= []
      unless instance_object
        @defined_permissions_store = self.class.instance.defined_permissions_store.clone
        @subject_store = self.class.instance.subject_store.clone
      end

      self
    end
    
    def self.instance
      @__instance__ ||= new(true)
    end  
      
    def self.define(&block)
      self
    end
      
    def self.method_missing(method, &block)
      yield PermissionHash.new(method) if block_given?
    end
      
    def self.defined_store
      @defined_permissions_store ||= {}
    end

    def self.for_controller
      @permissions_for_controller ||= {}
    end

    def self.add_for_controller(perm_hash)
      controller = perm_hash[:object].to_sym
      actions = perm_hash[:params].present? && perm_hash[:params].has_key?(:only) ? perm_hash[:params][:only] : [:all]      
      for_controller[controller] ||= {}
      actions.each do |action|
        for_controller[controller][action] ||= {:allow => [], :deny => []}
        for_controller[controller][action][perm_hash[:access_type]] << perm_hash[:permission_name]
      end
    end

    def fill_subject_from_external_store(subject_id, perm_storage, group_storage)
      perm_storage.get_for_subject(subject_id).each do |perm|
        self.subject_store << perm.permission_name.to_sym
      end
      groups = Grizzly::Groups.new
      groups.fill_subject_from_external_store(subject_id, group_storage)
      groups.subject_store.each do |group|
        if Grizzly::Groups.defined_store.has_key?(group.to_sym)
          self.subject_store.concat(Grizzly::Groups.defined_store[group.to_sym][:params])          
        end
      end
    end
  end
  
  class PermissionHash < Hash
    
    def initialize(method)
      self[:permission_name] = method.to_sym
    end
    
    def allow(*params)
      add(:allow, params)
    end
    
    def deny(*params)
      add(:deny, params)      
    end

    def add(perm_type, params)
      self[:access_type] = perm_type
      self[:object] = params.shift
      self[:params] = params.first
      Grizzly::Permissions.add_for_controller(self)
      Grizzly::Permissions.defined_store[self[:permission_name]] ||= []
      Grizzly::Permissions.defined_store[self[:permission_name]] << self
    end
  end
end