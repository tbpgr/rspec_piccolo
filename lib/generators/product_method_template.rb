require 'constants'
require 'generators/helper'

module RSpecPiccolo
  # Generators
  module Generators
    # ProductMethodTemplate
    class ProductMethodTemplate
      class << self
        def generate(method_names, module_indent)
          method_names.reduce([]) do |method_code, method_name|
            generate_each(method_name, module_indent, method_code)
            method_code
          end.join("\n").chop
        end

        def generate_each(method_name, module_indent, method_code)
          return if Helper.is_field? method_name
          if Helper.is_class_method?(method_name)
            method_name = "self.#{method_name.gsub('@c', '')}"
          end
          method_code << "#{module_indent}  def #{method_name}"
          method_code << "#{module_indent}    # TODO: implement your code"
          method_code << "#{module_indent}  end"
          method_code << ''
        end
      end
    end
  end
end
