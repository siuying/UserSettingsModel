module Model  
  module InstanceMethods
    def data
      @data ||= {}
    end
    
    def data=(data)
      @data = data
    end

    def _id
      @_id
    end
    
    def _id=(id)
      @_id = id
    end
    
    def save
      table = Array.new(self.class.table)
      
      if self._id != nil
        table[self._id] = self.data
      else
        table << self.data
    		self._id = table.count
      end

      self.class.table = table
    end
  
    def destroy
      table = self.class.table
      table.delete_at(self._id) if self._id
      self.class.table = table
    end
    
    def method_missing(name, *args)
      matched = name.to_s.match(/^([^=]+)(=)?$/)
      name = matched[1]
      modifier = matched[2]
      if self.class.attributes.include?(name.to_sym)
        if modifier == "="
          self.data[name] = args[0]
        else
          self.data[name]
        end
      else
        super
      end
    end
  end

  module ClassMethods
    def attribute(name)
      @attributes ||= []
      @attributes << name
    end
    
    def attributes
      @attributes ||= []
    end
    
    def settings
      @settings ||= NSUserDefaults.standardUserDefaults
    end
    
    def key
      "model." + self.description
    end
    
    def clear
      self.table = []
    end
    
    def get(id)
      data = self.settings[self.key][id]
      obj = self.new
      data.each do |key, value|
        obj.send("#{key}=".to_sym, value)
      end
      obj
    end

    def table
      self.settings[self.key] ||= []
      self.settings[self.key]
    end
    
    def table=(table)
      self.settings[self.key] = table
    end
  end
  
  def self.included(base)
    base.instance_eval do
      include InstanceMethods
      extend ClassMethods
    end
  end
  private_class_method :included
end