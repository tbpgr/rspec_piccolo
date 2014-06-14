module RSpecPiccolo
  # ModuleClassSeparator
  class ModuleClassSeparator
    def self.separate(name)
      return '', name unless has_module?(name)
      ret = name.match(/(.*)::(.*)/)
      [ret[1], ret[2]]
    end

    def self.has_module?(name)
      name.include?('::') ? true : false
    end
  end
end
