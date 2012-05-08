module Model  
  module InstanceMethods
    def data
      @data ||= {}
    end
    
    def data=(data)
      @data = data
    end

    def _id
      @data[:_id]
    end
    
    def _id=(id)
      @data[:_id] = id
    end
    
    def save
      table = self.class.table
      if self._id != nil
        table[self._id] = self.data
      else
        table = Array.new(table)
        table << self.data
    		self._id = self.class.next_key
      end
      self.class.table = table
      self
    end
  
    def destroy
      @data = nil
      table = Array.new(self.class.table)
      table.delete_at(self._id) if self._id
      self.class.table = table
    end
    
    def method_missing(method, *args)
      matched = method.to_s.match(/^([^=]+)(=)?$/)
      name = matched[1]
      modifier = matched[2]
      if self.class.attributes.include?(name.to_sym) || name == "_id"
        if modifier == "="
          self.data[name.to_sym] = args[0]
        else
          self.data[name.to_sym]
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
      "model.#{self.description}"
    end
    
    def max_key
      "#{self.key}.max"
    end
    
    def clear
      settings.removeObjectForKey(max_key)
      settings.removeObjectForKey(key)
      settings.synchronize
      self
    end

    def next_key
      if self.settings[max_key]
        self.settings[max_key] = self.settings[max_key] + 1        
      else
        self.settings[max_key] = 0
      end
    end
    
    def get(id)
      data = self.settings[self.key][id]
      if data
        obj = self.new
        data.each do |key, value|
          obj.send("#{key}=".to_sym, value)
        end
        obj._id = data[:_id]
        obj
      else
        nil
      end
    end
    
    def all
      table.collect do |item|
        get(item[:_id])
      end
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