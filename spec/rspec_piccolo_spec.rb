# encoding: utf-8
require "spec_helper"
require "rspec_piccolo"

describe RSpecPiccolo::Core do
  context :generate do
    CASE1_EXPECTED=<<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do

end
EOS

    CASE2_EXPECTED=<<-EOS
# encoding: utf-8
require "spec_helper"
require "hoge_core"

describe Hoge::Core do
  context :method1 do
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
        expected: "expected"
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

    CASE3_EXPECTED=<<-EOS
# encoding: utf-8
require "spec_helper"
require "only_class"

describe OnlyClass do
  context :method1 do
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
        expected: "expected"
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

    CASE4_EXPECTED=<<-EOS
# encoding: utf-8
require "spec_helper"
require "some_dir/hoge_core"

describe Hoge::Core do
  context :method1 do
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
        expected: "expected"
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

    cases = [
      {
        case_no: 1,
        case_title: "only classname",
        class_name: "Hoge::Core",
        class_path: "hoge_core",
        method_names: nil,
        expected_file_name: "./spec/hoge_core_spec.rb",
        expected_file_exists: true,
        expected_contents: CASE1_EXPECTED
      },
      {
        case_no: 2,
        case_title: "classname(with module) and method_names",
        class_name: "Hoge::Core",
        class_path: "hoge_core",
        method_names: ["method1", "method2"],
        expected_file_name: "./spec/hoge_core_spec.rb",
        expected_file_exists: true,
        expected_contents: CASE2_EXPECTED
      },
      {
        case_no: 3,
        case_title: "classname(with no module) and method_names",
        class_name: "OnlyClass",
        class_path: "only_class",
        method_names: ["method1", "method2"],
        expected_file_name: "./spec/only_class_spec.rb",
        expected_file_exists: true,
        expected_contents: CASE3_EXPECTED
      },
      {
        case_no: 4,
        case_title: "with directory, classname(with module) and method_names",
        class_name: "Hoge::Core",
        class_path: "some_dir/hoge_core",
        method_names: ["method1", "method2"],
        expected_file_name: "./spec/some_dir/hoge_core_spec.rb",
        expected_file_exists: true,
        expected_contents: CASE4_EXPECTED
      },
      {
        case_no: 5,
        case_title: "nil_class",
        class_name: nil,
        class_path: "some_dir/hoge_core",
        method_names: ["method1"],
        expect_error: true
      },
      {
        case_no: 6,
        case_title: "empty_class",
        class_name: "",
        class_path: "empty_class",
        method_names: ["method1"],
        expect_error: true
      },
      {
        case_no: 7,
        case_title: "nil_class_path",
        class_name: "nil_class_path",
        class_path: nil,
        method_names: ["method1"],
        expect_error: true
      },
      {
        case_no: 8,
        case_title: "empty_class_path",
        class_name: "empty_class_path",
        class_path: "",
        method_names: ["method1"],
        expect_error: true
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          piccolo = RSpecPiccolo::Core.new

          # -- when --
          if c[:expect_error]
            lambda {piccolo.generate(c[:class_name], c[:class_path], c[:method_names])}.should raise_error(RSpecPiccolo::RSpecPiccoloError)
            # case_after c
            next
          end
          piccolo.generate(c[:class_name], c[:class_path], c[:method_names])

          # -- then --
          expect(File.exists?(c[:expected_file_name])).to be_true
          actual = File.open(c[:expected_file_name]) {|f|f.read}
          expect(actual).to eq(c[:expected_contents])
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
        File.delete(c[:expected_file_name]) if File.exists?(c[:expected_file_name])
      end
    end
  end
end
