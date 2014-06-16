require 'constants'
require 'active_support/inflector'
require 'generators/helper'

module RSpecPiccolo
  # Generators
  module Generators
    # MethodTemplate
    class MethodTemplate
      def initialize(class_name, method_names, options)
        @class_name = class_name
        @method_names = method_names
        @options = options
      end

      def generate
        return '' if @method_names.nil?
        instance_name = @class_name.gsub('::', '_').underscore.downcase
        method_templates = []
        @method_names.each do |method_name|
          generate_each(
            method_name, method_templates, instance_name, reportable_case,
            Constants::METHOD_TEMPLATE)
        end
        method_templates.join("\n")
      end

      private

      def reportable_case
        @options[:reportable] ? Constants::REPORTABLE_CASE.chop : ''
      end

      # rubocop:disable UnusedMethodArgument, UselessAssignment
      def generate_each(
        method_name, method_templates, iname, reportable_case, template)
        return if Helper.field?(method_name)
        is_cmethod = Helper.class_method?(method_name)
        method_name = method_name.gsub('@c', '') if is_cmethod
        given_src = get_given_src(is_cmethod, iname)
        when_src = get_when_src(is_cmethod, iname, method_name)
        reportable_case_before = get_report_case_before(method_name)
        reportable_case_after = report_case_after
        reportable_case_ret = report_case_ret
        method_templates << ERB.new(template).result(binding)
      end
      # rubocop:enable UnusedMethodArgument, UselessAssignment

      def get_report_case_before(method_name)
        if @options[:reportable]
          ret = Constants::REPORTABLE_CASE_BEFORE.dup.chop
          ret.gsub('method_name', method_name)
        else
          ''
        end
      end

      def report_case_after
        if @options[:reportable]
          Constants::REPORTABLE_CASE_AFTER.dup.chop
        else
          ''
        end
      end

      def report_case_ret
        if @options[:reportable]
          Constants::REPORTABLE_CASE_RET.dup
        else
          ''
        end
      end

      def get_given_src(is_class_method, instance_name)
        if is_class_method
          '# nothing'
        else
          "#{instance_name} = #{@class_name}.new"
        end
      end

      def get_when_src(
        is_class_method, instance_name, method_name)
        if is_class_method
          "# actual = #{@class_name}.#{method_name}"
        else
          "# actual = #{instance_name}.#{method_name}"
        end
      end
    end
  end
end
