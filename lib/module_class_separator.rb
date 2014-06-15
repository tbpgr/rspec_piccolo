module RSpecPiccolo
  # ModuleClassSeparator
  class ModuleClassSeparator
    def self.separate(name)
      return '', name unless module?(name)
      ret = name.match(/(.*)::(.*)/)
      [ret[1], ret[2]]
    end

    def self.module?(name)
      name.include?('::') ? true : false
    end
  end
end
