module Grizzly
  class Storage
    
    attr_accessor :type
    attr_accessor :name
    attr_accessor :params
    
    def initialize(type, name)
      @type, @name = type, name
      self
    end
    
    def set
      case @type
      when :permission
        UserPermission.create(:permission_name => @name.to_s)
      when :group
        UserGroup.create(:group_name => @name.to_s)
      end
    end
    
    def get
      case @type
      when :permission
        UserPermission.find_by_name(@name)
      when :group
        UserGroup.find_by_name(@name)
      end
    end
  end
end