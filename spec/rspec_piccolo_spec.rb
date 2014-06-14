# encoding: utf-8
require 'spec_helper'
require 'rspec_piccolo'
require 'fileutils'

describe RSpecPiccolo::Core do
  context :generate do
    CASE1_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do


end
EOS

    CASE2_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method2

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
end
EOS

    CASE3_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "only_class"

describe OnlyClass do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          only_class = OnlyClass.new

          # -- when --
          # TODO: implement execute code
          # actual = only_class.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          only_class = OnlyClass.new

          # -- when --
          # TODO: implement execute code
          # actual = only_class.method2

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
end
EOS

    CASE4_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "some_dir/hoge_core"

describe Hoge::Core do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method2

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
end
EOS

    CASE9_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "some_dir/some_sub_dir/hoge_core"

describe Hoge::Core do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method2

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
end
EOS

    CASE10_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do
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

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
        success_hook: success,
        failure_hook: failure
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

          # -- then --
          # TODO: implement assertion code
          # ret = expect(actual).to eq(c[:expected])
        ensure
          case_after c
          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
        end
      end

      def case_before(c)
        # implement each case before
        File.open(REPORT_FILE, "a") {|f|f.print "method1\\t#\{c[:case_no]}\\t#\{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
        success_hook: success,
        failure_hook: failure
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method2

          # -- then --
          # TODO: implement assertion code
          # ret = expect(actual).to eq(c[:expected])
        ensure
          case_after c
          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
        end
      end

      def case_before(c)
        # implement each case before
        File.open(REPORT_FILE, "a") {|f|f.print "method2\\t#\{c[:case_no]}\\t#\{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
EOS

    CASE11_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          # TODO: implement execute code
          # actual = Hoge::Core.method2

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
end
EOS

    CASE12_EXPECTED = <<-EOS
# encoding: utf-8
require "spec_helper"
require "some_dir/hoge_core"

describe Hoge::Core do

  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge_core = Hoge::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge_core.method1

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

  context :method2 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=\#{c[:case_no]}|case_title=\#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          # TODO: implement execute code
          # actual = Hoge::Core.method2

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
end
EOS

    CASE12_PRODUCT_EXPECTED = <<-EOS
# encoding: utf-8

module Hoge
  class Core
    def method1
      # TODO: implement your code
    end

    def self.method2
      # TODO: implement your code
    end
  end
end
    EOS

    CASE13_EXPECTED = CASE12_EXPECTED

    CASE13_PRODUCT_EXPECTED = <<-EOS
# encoding: utf-8
require 'attributes_initializable'
module Hoge
  class Core
    include AttributesInitializable
    attr_accessor_init :field1, :field2

    def method1
      # TODO: implement your code
    end

    def self.method2
      # TODO: implement your code
    end
  end
end
    EOS

    cases = [
      {
        case_no: 1,
        case_title: 'only classname',
        class_name: 'Hoge::Core',
        class_path: 'hoge_core',
        method_names: nil,
        expected_file_name: './spec/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE1_EXPECTED
      },
      {
        case_no: 2,
        case_title: 'classname(with module) and method_names',
        class_name: 'Hoge::Core',
        class_path: 'hoge_core',
        method_names: %w(method1 method2),
        expected_file_name: './spec/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE2_EXPECTED
      },
      {
        case_no: 3,
        case_title: 'classname(with no module) and method_names',
        class_name: 'OnlyClass',
        class_path: 'only_class',
        method_names: %w(method1 method2),
        expected_file_name: './spec/only_class_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE3_EXPECTED
      },
      {
        case_no: 4,
        case_title: 'with directory, classname(with module) and method_names',
        class_name: 'Hoge::Core',
        class_path: 'some_dir/hoge_core',
        del_dir: 'some_dir',
        method_names: %w(method1 method2),
        expected_file_name: './spec/some_dir/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE4_EXPECTED
      },
      {
        case_no: 5,
        case_title: 'nil_class',
        class_name: nil,
        class_path: 'some_dir/hoge_core',
        method_names: ['method1'],
        expect_error: true
      },
      {
        case_no: 6,
        case_title: 'empty_class',
        class_name: '',
        class_path: 'empty_class',
        method_names: ['method1'],
        expect_error: true
      },
      {
        case_no: 7,
        case_title: 'nil_class_path',
        class_name: 'nil_class_path',
        class_path: nil,
        method_names: ['method1'],
        expect_error: true
      },
      {
        case_no: 8,
        case_title: 'empty_class_path',
        class_name: 'empty_class_path',
        class_path: '',
        method_names: ['method1'],
        expect_error: true
      },
      {
        case_no: 9,
        case_title: 'with two directories, classname(with module) and method_names',
        class_name: 'Hoge::Core',
        class_path: 'some_dir/some_sub_dir/hoge_core',
        del_dir: 'some_dir',
        method_names: %w(method1 method2),
        expected_file_name: './spec/some_dir/some_sub_dir/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE9_EXPECTED
      },
      {
        case_no: 10,
        case_title: 'classname(with module) and method_names reportable',
        class_name: 'Hoge::Core',
        class_path: 'hoge_core',
        method_names: %w(method1 method2),
        reportable: true,
        expected_file_name: './spec/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE10_EXPECTED
      },
      {
        case_no: 11,
        case_title: 'classname(with module) and method_names(instance method, class method)',
        class_name: 'Hoge::Core',
        class_path: 'hoge_core',
        method_names: ['method1', 'method2@c'],
        expected_file_name: './spec/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_contents: CASE11_EXPECTED
      },
      {
        case_no: 12,
        case_title: 'classname(with module) and method_names(instance method, class method) and product code output',
        class_name: 'Hoge::Core',
        class_path: 'some_dir/hoge_core',
        method_names: ['method1', 'method2@c'],
        productcode: true,
        expected_file_name: './spec/some_dir/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_product_file_name: './lib/some_dir/hoge_core.rb',
        expected_product_file_exists: true,
        expected_contents: CASE12_EXPECTED,
        expected_product_contents: CASE12_PRODUCT_EXPECTED
      },
      {
        case_no: 13,
        case_title: 'classname(with module) and method_names(instance method, class method, field1, field2) and product code output',
        class_name: 'Hoge::Core',
        class_path: 'some_dir/hoge_core',
        method_names: ['method1', 'method2@c', 'field1@f', 'field2@f'],
        productcode: true,
        expected_file_name: './spec/some_dir/hoge_core_spec.rb',
        expected_file_exists: true,
        expected_product_file_name: './lib/some_dir/hoge_core.rb',
        expected_product_file_exists: true,
        expected_contents: CASE13_EXPECTED,
        expected_product_contents: CASE13_PRODUCT_EXPECTED
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          piccolo = RSpecPiccolo::Core.new
          options = {}
          options[:reportable] = c[:reportable]
          options[:productcode] = c[:productcode]

          # -- when --
          if c[:expect_error]
            lambda { piccolo.generate(c[:class_name], c[:class_path], c[:method_names], options) }.should raise_error(RSpecPiccolo::RSpecPiccoloError)
            next
          end
          piccolo.generate(c[:class_name], c[:class_path], c[:method_names], options)

          # -- then --
          expect(File.exist?(c[:expected_file_name])).to be_true
          actual = File.open(c[:expected_file_name]) { |f|f.read }
          expect(actual).to eq(c[:expected_contents])
          if c[:productcode]
            expect(File.exist?(c[:expected_product_file_name])).to be_true
            actual = File.open(c[:expected_product_file_name]) { |f|f.read }
            expect(actual).to eq(c[:expected_product_contents])
          end
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
        return if c[:expect_error]
        File.delete(c[:expected_file_name]) if File.exist?(c[:expected_file_name])
        FileUtils.rm_rf('spec/some_dir')
        File.delete(c[:expected_product_file_name]) if c[:expected_product_file_name] && File.exist?(c[:expected_product_file_name])
        FileUtils.rm_rf('lib/some_dir')
      end
    end
  end
end
