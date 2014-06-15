require 'constants'
require 'active_support/inflector'

module RSpecPiccolo
  # Generators
  module Generators
    # Helper
    class Helper
      def self.class_method?(method_name)
        method_name.match(/@c$/) ? true : false
      end

      def self.field?(method_name)
        method_name.match(/@f$/) ? true : false
      end
    end
  end
end
