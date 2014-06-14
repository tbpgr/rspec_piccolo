require 'constants'
require 'active_support/inflector'
require 'generators/helper'

module RSpecPiccolo
  # Generators
  module Generators
    # MethodTemplate
    class MethodTemplate
      class << self
        def generate(class_name, method_names, options)
          return '' if method_names.nil?
          reportable_case = options[:reportable] ? Constants::REPORTABLE_CASE.chop : ''
          instance_name = class_name.gsub('::', '_').underscore.downcase
          method_templates = []
          method_names.each { |method_name|generate_each(class_name, method_name, method_templates, instance_name, options, reportable_case) }
          method_templates.join("\n")
        end

        private

        def generate_each(class_name, method_name, method_templates, instance_name, options, reportable_case)
          return if Helper.is_field?(method_name)
          is_class_method = Helper.is_class_method?(method_name)
          method_name = method_name.gsub('@c', '') if is_class_method
          given_src = get_given_src(is_class_method, instance_name, class_name)
          when_src = get_when_src(is_class_method, instance_name, class_name, method_name)
          reportable_case_before = options[:reportable] ? Constants::REPORTABLE_CASE_BEFORE.dup.chop : ''
          reportable_case_before.gsub!('method_name', method_name)
          reportable_case_after = options[:reportable] ? Constants::REPORTABLE_CASE_AFTER.dup.chop : ''
          reportable_case_ret = options[:reportable] ? Constants::REPORTABLE_CASE_RET.dup : ''
          method_templates << ERB.new(Constants::METHOD_TEMPLATE).result(binding)
        end

        def get_given_src(is_class_method, instance_name, class_name)
          is_class_method ? '# nothing' : "#{instance_name} = #{class_name}.new"
        end

        def get_when_src(is_class_method, instance_name, class_name, method_name)
          is_class_method ? "# actual = #{class_name}.#{method_name}" : "# actual = #{instance_name}.#{method_name}"
        end
      end
    end
  end
end
