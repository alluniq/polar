module Grizzly #nodoc
  class DefaultGroups
    
    # This method is executed whenever a default group is defined
    # in subject's model
    def method_missing(method, *params)
      Groups.instance.subject_store << method
      self
    end
    
    # Protects from creating more than one instance of this class
    def self.instance
      @__instance__ ||= new
    end
    
  end
  
  class Groups      
    attr_accessor :defined_groups_store
    attr_accessor :subject_store

    def initialize(instance_object = false)
      @defined_groups_store ||= []
      @subject_store ||= []
      unless instance_object
        @defined_groups_store = self.class.instance.defined_groups_store.clone
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
      yield GroupHash.new(method) if block_given?
    end
    
    def self.defined_store
      @defined_groups_store ||= {}
    end

    def fill_subject_from_external_store(subject_id, storage)
      storage.get_for_subject(subject_id).each do |group|
        self.subject_store << group.group_name.to_sym
      end
    end
  end
  
  class GroupHash < Hash
    
    def initialize(method)
      self[:group_name] = method.to_sym
    end
    
    def have(*params)
      self[:params] = params
      Grizzly::Groups.defined_store[self[:group_name]] = self
    end
    
    def deny(*params)
      
    end
  end
end