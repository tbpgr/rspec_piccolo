require 'constants'
require 'active_support/inflector'

module RSpecPiccolo
  # Generators
  module Generators
    # Helper
    class Helper
      def self.is_class_method?(method_name)
        method_name.match(/@c$/) ? true : false
      end

      def self.is_field?(method_name)
        method_name.match(/@f$/) ? true : false
      end
    end
  end
end
