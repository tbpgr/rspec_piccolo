require "rspec_piccolo/version"
require "erb"
require 'active_support/inflector'
require 'fileutils'

module RSpecPiccolo
  #= RSpecPiccolo Core
  class Core
    #== RSPec class template
    CLASS_TEMPLATE=<<-EOS
# encoding: utf-8
require "spec_helper"
require "<%=class_path%>"

describe <%=class_name%> do
<%=methods_template%>
end
    EOS

    #== RSPec method template
    METHOD_TEMPLATE=<<-EOS
  context :<%=method_name%> do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected"
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          <%=instance_name%> = <%=class_name%>.new

          # -- when --
          # TODO: implement execute code
          # actual = <%=instance_name%>.<%=method_name%>

          # -- then --
          # TODO: implement assertion code
          # expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
EOS

    #== initialize
    def initialize
      @contents = ""
    end

    #== generate rspec test case
    #=== params
    #- class_name: spec's module+class full name
    #- class_path: spec's class_path(if you want to create spec/hoge_spec.rb, you should set 'hoge_spec.rb')
    #- method_names: target class's method list
    def generate(class_name, class_path, method_names)
      validate_class_name class_name
      validate_class_path class_path
      methods_template = generate_method_template(class_name, method_names)
      @contents = generate_class_template(class_name, class_path, methods_template)
      create_spec_directory class_path
      File.open("./spec/#{class_path}_spec.rb", "w") {|f|f.puts @contents}
    end

    private
    def validate_class_name(class_name)
      raise RSpecPiccoloError.new("class_name is not allowed nil value") if class_name.nil?
      raise RSpecPiccoloError.new("class_name is not allowed empty value") if class_name.empty?
    end

    def validate_class_path(class_path)
      raise RSpecPiccoloError.new("class_path is not allowed nil value") if class_path.nil?
      raise RSpecPiccoloError.new("class_path is not allowed empty value") if class_path.empty?
    end

    def generate_method_template(class_name, method_names)
      return "" if method_names.nil?
      instance_name = class_name.gsub('::', '_').underscore.downcase
      method_templates = []
      method_names.each do |method_name|
        method_templates << ERB.new(METHOD_TEMPLATE).result(binding)
      end
      method_templates.join("\n")
    end

    def create_spec_directory(class_path)
      return if Dir.exists? "./spec/#{File.dirname(class_path)}"
      FileUtils.mkdir_p("./spec/#{File.dirname(class_path)}")
    end

    def generate_class_template(class_name, class_path, methods_template)
      ERB.new(CLASS_TEMPLATE).result(binding)
    end
  end

  class RSpecPiccoloError < StandardError;end
end
