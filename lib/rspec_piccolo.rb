require 'rspec_piccolo/version'
require 'erb'
require 'active_support/inflector'
require 'fileutils'

module RSpecPiccolo
  # RSpecPiccolo Core
  class Core
    # RSPec class template
    CLASS_TEMPLATE = <<-EOS
# encoding: utf-8
require "spec_helper"
require "<%=class_path%>"

describe <%=class_name%> do
<%=reportable_prepare%>
<%=methods_template%>
end
    EOS

    REPORTABLE_PREPARE = <<-EOS
  REPORT = "rspec_report"
  DIRS = File.path(__FILE__).gsub(/^.*\\/spec\\//, '').gsub(File.basename(__FILE__), '')
  OUT_DIR = "./#\{REPORT}/#\{DIRS}"
  REPORT_NAME = report_name = File.basename(__FILE__, ".rb")
  REPORT_FILE = "#\{OUT_DIR}#\{REPORT_NAME}.tsv"

  mkspec_report = Proc.new do
    Dir.mkdir(REPORT) unless File.exists?(REPORT)
    FileUtils.mkdir_p(OUT_DIR) unless File.exists?(OUT_DIR)
    File.open(REPORT_FILE, "w") {|f|f.puts "method\\tcase\\ttitle\\tsuccess\\/failure"}
  end.call

  success = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\\tsuccess"}}
  failure = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\\tfailure"}}
    EOS

    # RSPec method template
    METHOD_TEMPLATE = <<-EOS
  context :<%=method_name%> do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",<%=reportable_case%>
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          <%=given_src%>

          # -- when --
          # TODO: implement execute code
          <%=when_src%>

          # -- then --
          # TODO: implement assertion code
          # <%=reportable_case_ret%>expect(actual).to eq(c[:expected])
        ensure
          case_after c<%=reportable_case_after%>
        end
      end

      def case_before(c)
        # implement each case before<%=reportable_case_before%>
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
EOS

    REPORTABLE_CASE = <<-EOS

        success_hook: success,
        failure_hook: failure
    EOS

    REPORTABLE_CASE_BEFORE = <<-EOS

        File.open(REPORT_FILE, "a") {|f|f.print "method_name\\t\#{c[:case_no]}\\t\#{c[:case_title]}"}
    EOS

    REPORTABLE_CASE_AFTER = <<-EOS

          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
    EOS

    REPORTABLE_CASE_RET = "ret = "

    PRODUCT_CLASS_TEMPLATE = <<-EOS
# encoding: utf-8

<%=module_start%>
<%=module_indent%>class <%=class_name%>
<%=methods_template%>
<%=module_indent%>end
<%=module_end%>
    EOS

    # initialize
    def initialize
      @contents = ''
    end

    #== generate rspec test case
    #=== params
    #- class_name: spec's module+class full name
    #- class_path: spec's class_path(if you want to create spec/hoge_spec.rb, you should set 'hoge_spec.rb')
    #- method_names: target class's method list
    #- options: options
    def generate(class_name, class_path, method_names, options)
      validate_class_name class_name
      validate_class_path class_path
      methods_template = generate_method_template(class_name, method_names, options)
      @contents = generate_class_template(class_name, class_path, methods_template.chop, options)
      create_spec_directory class_path
      File.open("./spec/#{class_path}_spec.rb", 'w:UTF-8') { |f|f.puts @contents }
      output_product_code(class_name, class_path, method_names) if output_product? options
    end

    private
    def validate_class_name(class_name)
      fail RSpecPiccoloError.new('class_name is not allowed nil value') if class_name.nil?
      fail RSpecPiccoloError.new('class_name is not allowed empty value') if class_name.empty?
    end

    def validate_class_path(class_path)
      fail RSpecPiccoloError.new('class_path is not allowed nil value') if class_path.nil?
      fail RSpecPiccoloError.new('class_path is not allowed empty value') if class_path.empty?
    end

    def generate_method_template(class_name, method_names, options)
      return '' if method_names.nil?
      reportable_case = options[:reportable] ? REPORTABLE_CASE.chop : ''
      instance_name = class_name.gsub('::', '_').underscore.downcase
      method_templates = []
      method_names.each do |method_name|
        is_class_method = is_class_method?(method_name)
        method_name = method_name.gsub('@c', '') if is_class_method
        given_src = is_class_method ? '# nothing' : "#{instance_name} = #{class_name}.new"
        when_src = is_class_method ? "# actual = #{class_name}.#{method_name}" : "# actual = #{instance_name}.#{method_name}"
        reportable_case_before = options[:reportable] ? REPORTABLE_CASE_BEFORE.dup.chop : ''
        reportable_case_before.gsub!('method_name', method_name)
        reportable_case_after = options[:reportable] ? REPORTABLE_CASE_AFTER.dup.chop : ''
        reportable_case_ret = options[:reportable] ? REPORTABLE_CASE_RET.dup : ''
        method_templates << ERB.new(METHOD_TEMPLATE).result(binding)
      end
      method_templates.join("\n")
    end

    def create_spec_directory(class_path)
      return if Dir.exists? "./spec/#{File.dirname(class_path)}"
      FileUtils.mkdir_p("./spec/#{File.dirname(class_path)}")
    end

    def generate_class_template(class_name, class_path, methods_template, options)
      reportable_prepare = options[:reportable] ? REPORTABLE_PREPARE : ''
      ERB.new(CLASS_TEMPLATE).result(binding)
    end

    def output_product?(options)
      options[:productcode] ? true : false
    end

    def output_product_code(class_name, class_path, method_names)
      has_module = has_module? class_name
      module_indent = has_module ? '  ' : ''
      module_name, class_name = get_module_class_names class_name, has_module
      methods_template = generate_product_method_template(method_names, module_indent)
      contents = generate_product_class_template(module_name, class_name, class_path, methods_template.chop, module_indent, has_module)
      create_lib_directory(class_path)
      File.open("./lib/#{class_path}.rb", 'w:UTF-8') { |f|f.puts contents }
    end

    def create_lib_directory(class_path)
      return if Dir.exists? "./lib/#{File.dirname(class_path)}"
      FileUtils.mkdir_p("./lib/#{File.dirname(class_path)}")
    end

    def has_module?(class_name)
      class_name.include?('::') ? true : false
    end

    def get_module_class_names(class_name, has_module)
      return '', class_name unless has_module
      ret = class_name.match /(.*)::(.*)/
      return ret[1], ret[2]
    end

    def generate_product_method_template(method_names, module_indent)
      method_code = []
      method_names.each do |method_name|
        method_name = "self.#{method_name.gsub('@c', '')}" if is_class_method?(method_name)
        method_code << "#{module_indent}  def #{method_name}"
        method_code << "#{module_indent}    # TODO: implement your code"
        method_code << "#{module_indent}  end"
        method_code << ""
      end
      method_code.join("\n")
    end

    def is_class_method?(method_name)
      method_name.match(/@c$/) ? true : false
    end

    def generate_product_class_template(module_name, class_name, class_path, methods_template, module_indent, has_module)
      module_start = ""
      module_end = ""
      if has_module
        module_start = "module #{module_name}"
        module_end = "end"
      end
      ERB.new(PRODUCT_CLASS_TEMPLATE).result(binding)
    end
  end

  class RSpecPiccoloError < StandardError; end
end
