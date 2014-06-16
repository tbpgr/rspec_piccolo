require 'rspec_piccolo/version'
require 'erb'
require 'active_support/inflector'
require 'fileutils'
require 'constants'
require 'module_class_separator'
require 'validators'
require 'generators'
require 'generators/helper'

module RSpecPiccolo
  # RSpecPiccolo Core
  class Core
    # initialize
    def initialize
      @contents = ''
    end

    # == generate rspec test case
    # === params
    #- class_name: spec's module+class full name
    #- class_path: spec's class_path
    #  (if you want to create spec/hoge_spec.rb, you should set 'hoge_spec.rb')
    #- method_names: target class's method list
    #- options: options
    def generate(class_name, class_path, method_names, options)
      validates(class_name, class_path)
      mtemplate = generate_method_template(class_name, method_names, options)
      @contents = generate_class_template(
        class_name, class_path, mtemplate.chop, options)
      create_spec_directory class_path
      File.open("./spec/#{class_path}_spec.rb", 'w:UTF-8') do |f|
        f.puts @contents
      end
      return unless output_product?(options)
      output_product_code(class_name, class_path, method_names)
    end

    private

    def validates(class_name, class_path)
      Validators::NilEmpty.new('class_name').validate(class_name)
      Validators::NilEmpty.new('class_path').validate(class_path)
    end

    def generate_method_template(class_name, method_names, options)
      mt = Generators::MethodTemplate.new(class_name, method_names, options)
      mt.generate
    end

    def create_spec_directory(class_path)
      return if Dir.exist? "./spec/#{File.dirname(class_path)}"
      FileUtils.mkdir_p("./spec/#{File.dirname(class_path)}")
    end

    # rubocop:disable UnusedMethodArgument
    def generate_class_template(
      class_name, class_path, methods_template, options)
      reportable_prepare = \
          if options[:reportable]
            Constants::REPORTABLE_PREPARE
          else
            ''
          end
      ERB.new(Constants::CLASS_TEMPLATE).result(binding)
    end
    # rubocop:enable UnusedMethodArgument

    def output_product?(options)
      options[:productcode] ? true : false
    end

    def output_product_code(cname, cpath, mnames)
      hasm = ModuleClassSeparator.module?(cname)
      has_field = field?(mnames)
      mindent = hasm ? '  ' : ''
      require_rb = has_field ? "require 'attributes_initializable'" : ''
      contents = generate_product_class_template(
        cname, mindent, hasm, require_rb, mnames)
      create_lib_directory(cpath)
      File.open("./lib/#{cpath}.rb", 'w:UTF-8') { |f|f.puts contents }
    end

    def create_lib_directory(class_path)
      return if Dir.exist? "./lib/#{File.dirname(class_path)}"
      FileUtils.mkdir_p("./lib/#{File.dirname(class_path)}")
    end

    def field?(method_names)
      method_names.each do |method_name|
        return true if Generators::Helper.field?(method_name)
      end
      false
    end

    # rubocop:disable UnusedMethodArgument
    def generate_product_class_template(
      class_name, module_indent, has_module, require_rb, mnames)
      module_name, class_name = ModuleClassSeparator.separate(class_name)
      methods_template = Generators::ProductMethodTemplate.generate(
        mnames, module_indent)
      fields = get_fields(mnames, module_indent)
      module_start, module_end = module_start_end(has_module, module_name)
      ERB.new(Constants::PRODUCT_CLASS_TEMPLATE).result(binding)
    end
    # rubocop:enable UnusedMethodArgument

    def module_start_end(has_module, module_name)
      module_start = ''
      module_end = ''
      if has_module
        module_start = "module #{module_name}"
        module_end = 'end'
      end
      [module_start, module_end]
    end

    def get_fields(method_names, module_indent)
      return '' unless field?(method_names)
      ret = []
      ret << "#{module_indent}  include AttributesInitializable\n"
      ret << "#{module_indent}  attr_accessor_init "
      method_names.each do |method_name|
        next unless Generators::Helper.field?(method_name)
        ret << ":#{method_name.gsub(/@f/, '')}, "
      end
      "#{ret.join.chop.chop}\n\n"
    end
  end
end
