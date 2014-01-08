# RSpecPiccolo

RSpecPiccolo generate rspec's spec with list-cases for each method. 

## Installation

Add this line to your application's Gemfile:

    gem 'rspec_piccolo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_piccolo

## Usage
You have to execute these commands in your project root directory.

### Case only class_name, class_place
~~~bash
piccolo execute SomeClass some_class_place
~~~

Result, spec/some_class_place_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "some_class_place"

describe SomeClass do

end
~~~

### Case module_name + class_name, directory_name + class_place
~~~bash
piccolo execute SomeModule::SomeClass some_directory/some_class_place
~~~

Result, spec/some_directory/some_class_place_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "some_directory/some_class_place"

describe SomeModule::SomeClass do

end
~~~

### Case class_name, class_place, method_names
~~~bash
piccolo execute SomeClass some_class_place method1 method2
~~~

Result, spec/some_class_place_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "some_class_place"

describe SomeClass do
  context :method1 do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected"
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          some_class = SomeClass.new

          # -- when --
          # TODO: implement execute code
          # actual = some_class.method1

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
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

            # -- given --
            some_class = SomeClass.new

            # -- when --
            # TODO: implement execute code
            # actual = some_class.method2

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
~~~

### Case class_name, class_place, method_names with product code
~~~bash
piccolo execute SomeClass some_class_place method1 method2 -p
~~~

Result, spec/some_class_place_spec.rb
~~~ruby
# omission
~~~

Result, lib/some_class_place.rb
~~~ruby
# encoding: utf-8

class SomeClass
  def method1
    # TODO: implement your code
  end

  def method2
    # TODO: implement your code
  end
end
~~~

### Case class_name, class_place, method_names, fields with product code
~~~bash
piccolo execute SomeClass some_class_place method1 method2 field1 field2 -p
~~~

Result, spec/some_class_place_spec.rb
~~~ruby
# omission
~~~

Result, lib/some_class_place.rb
~~~ruby
# encoding: utf-8
require 'attributes_initializable'
class SomeClass
  include AttributesInitializable
  attr_accessor_init :field1, :field2

  def method1
    # TODO: implement your code
  end

  def method2
    # TODO: implement your code
  end
end
~~~

### Case class_name, class_place, instance_method_name and class_method_name
~~~bash
piccolo execute SomeClass some_class_place instance_method class_method@c
~~~

Result, spec/some_class_place_spec.rb
~~~ruby
$ cat spec/some_class_place_spec.rb
# encoding: utf-8
require "spec_helper"
require "some_class_place"

describe SomeClass do

  context :instance_method do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          some_class = SomeClass.new

          # -- when --
          # TODO: implement execute code
          # actual = some_class.instance_method

          # -- then --
          # TODO: implement assertion code
          # ret = expect(actual).to eq(c[:expected])
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

  context :class_method do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected",
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          # TODO: implement execute code
          # actual = SomeClass.class_method

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
~~~

### Case class_name, class_place, method_names with report
you can output report by -r(reportable) option.

~~~bash
piccolo execute Hoge hoge/hige/hoge hoge hige -r
~~~

product code
~~~ruby
# encoding: utf-8

class Hoge
  def hoge
    "hoge"
  end
  def hige
    "hige"
  end
end

~~~

Result, spec/hoge/hige/hoge_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "hoge/hige/hoge"

describe Hoge do
  REPORT = "rspec_report"
  DIRS = File.path(__FILE__).gsub(/^.*\/spec\//, '').gsub(File.basename(__FILE__), '')
  OUT_DIR = "./#{REPORT}/#{DIRS}"
  REPORT_NAME = report_name = File.basename(__FILE__, ".rb")
  REPORT_FILE = "#{OUT_DIR}#{REPORT_NAME}.tsv"

  mkspec_report = Proc.new do
    Dir.mkdir(REPORT) unless File.exists?(REPORT)
    FileUtils.mkdir_p(OUT_DIR) unless File.exists?(OUT_DIR)
    File.open(REPORT_FILE, "w") {|f|f.puts "method\tcase\ttitle\tsuccess\/failure"}
  end.call

  success = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\tsuccess"}}
  failure = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\tfailure"}}

  context :hoge do
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
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge = Hoge.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge.hoge

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
        File.open(REPORT_FILE, "a") {|f|f.print "hoge\t#{c[:case_no]}\t#{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :hige do
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
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge = Hoge.new

          # -- when --
          # TODO: implement execute code
          # actual = hoge.hige

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
        File.open(REPORT_FILE, "a") {|f|f.print "hige\t#{c[:case_no]}\t#{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
~~~

Edit manually, spec/hoge/hige/hoge_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "hoge/hige/hoge"

describe Hoge do
  REPORT = "rspec_report"
  DIRS = File.path(__FILE__).gsub(/^.*\/spec\//, '').gsub(File.basename(__FILE__), '')
  OUT_DIR = "./#{REPORT}/#{DIRS}"
  REPORT_NAME = report_name = File.basename(__FILE__, ".rb")
  REPORT_FILE = "#{OUT_DIR}#{REPORT_NAME}.tsv"

  mkspec_report = Proc.new do
    Dir.mkdir(REPORT) unless File.exists?(REPORT)
    FileUtils.mkdir_p(OUT_DIR) unless File.exists?(OUT_DIR)
    File.open(REPORT_FILE, "w") {|f|f.puts "method\tcase\ttitle\tsuccess\/failure"}
  end.call

  success = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\tsuccess"}}
  failure = Proc.new {|c|File.open(REPORT_FILE, "a") {|f|f.puts "\tfailure"}}

  context :hoge do
    cases = [
      {
        case_no: 1,
        case_title: "valid",
        expected: "hoge",
        success_hook: success,
        failure_hook: failure
      },
      {
        case_no: 2,
        case_title: "invalid",
        expected: "hige",
        success_hook: success,
        failure_hook: failure
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge = Hoge.new

          # -- when --
          actual = hoge.hoge

          # -- then --
          ret = expect(actual).to eq(c[:expected])
        ensure
          case_after c
          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
        end
      end

      def case_before(c)
        # implement each case before
        File.open(REPORT_FILE, "a") {|f|f.print "hoge\t#{c[:case_no]}\t#{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :hige do
    cases = [
      {
        case_no: 1,
        case_title: "valid",
        expected: "hige",
        success_hook: success,
        failure_hook: failure
      },
      {
        case_no: 2,
        case_title: "invalid",
        expected: "hoge",
        success_hook: success,
        failure_hook: failure
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          hoge = Hoge.new

          # -- when --
          actual = hoge.hige

          # -- then --
          ret = expect(actual).to eq(c[:expected])
        ensure
          case_after c
          sf_hook = ret ? c[:success_hook] : c[:failure_hook]
          sf_hook.call(c)
        end
      end

      def case_before(c)
        # implement each case before
        File.open(REPORT_FILE, "a") {|f|f.print "hige\t#{c[:case_no]}\t#{c[:case_title]}"}
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
~~~

Execute rspec command. 
~~~bash
$rspec
Run options: include {:focus=>true}

All examples were filtered out; ignoring {:focus=>true}
.F.F

Failures:

  1) Hoge hoge |case_no=2|case_title=invalid
     Failure/Error: ret = expect(actual).to eq(c[:expected])

       expected: "hige"
            got: "hoge"

       (compared using ==)
     # ./spec/hoge/hige/hoge_spec.rb:51:in `block (4 levels) in <top (required)>'

  2) Hoge hige |case_no=2|case_title=invalid
     Failure/Error: ret = expect(actual).to eq(c[:expected])

       expected: "hoge"
            got: "hige"

       (compared using ==)
     # ./spec/hoge/hige/hoge_spec.rb:100:in `block (4 levels) in <top (required)>'

Finished in 0.009 seconds
4 examples, 2 failures

Failed examples:

rspec ./spec/hoge/hige/hoge_spec.rb:40 # Hoge hoge |case_no=2|case_title=invalid
rspec ./spec/hoge/hige/hoge_spec.rb:89 # Hoge hige |case_no=2|case_title=invalid
~~~

you get tsv report.
~~~bash
$ tree
┠ lib
┃┗ hoge
┃     ┗ hige
┃         ┗ hoge.rb
┠ rspec_report
┃┗ hoge
┃     ┗ hige
┃         ┗ hoge_spec.tsv
┗ spec
    ┠ hoge
    ┃ ┗ hige
    ┃     ┗ hoge_spec.rb
    ┗ spec_helper.rb

$cat rspec_report/hoge/hige/hoge_spec.tsv
method	case	title	success/failure
hoge	1	valid	success
hoge	2	invalid	failure
hige	1	valid	success
hige	2	invalid	failure
~~~

## Pragmatic Usase
You can edit your spec template like this sample.

This sample, you create fizzbuzz application.

If your product-code is ...

lib/fizz_buzz.rb
~~~ruby
# encoding: utf-8

class FizzBuzz
  def fizz_buzz(num)
    ret = []
    ret << fizz(num)
    ret << buzz(num)
    ret.join == "" ? num.to_s : ret.join
  end

  private
  def fizz(num)
    "Fizz" if num % 3 == 0
  end

  def buzz(num)
    "Buzz" if num % 5 == 0
  end
end
~~~

you generate rspec template
~~~bash
rspec --init
~~~

You generate concrete spec by piccolo.
~~~bash
piccolo execute FizzBuzz fizz_buzz fizz_buzz
~~~

Generated spec is ...

spec/fizz_buzz_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "fizz_buzz"

describe FizzBuzz do
  context :fizz_buzz do
    cases = [
      {
        case_no: 1,
        case_title: "case_title",
        expected: "expected"
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          fizz_buzz = FizzBuzz.new

          # -- when --
          # TODO: implement execute code
          # actual = fizz_buzz.fizz_buzz

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
~~~

After edit, your spec is like this.

spec/fizz_buzz_spec.rb
~~~ruby
# encoding: utf-8
require "spec_helper"
require "fizz_buzz"

describe FizzBuzz do
  context :fizz_buzz do
    cases = [
      {
        case_no: 1,
        case_title: "fizz",
        input: 3,
        expected: "Fizz"
      },
      {
        case_no: 2,
        case_title: "buzz",
        input: 5,
        expected: "Buzz"
      },
      {
        case_no: 3,
        case_title: "fizzbuzz",
        input: 15,
        expected: "FizzBuzz"
      },
      {
        case_no: 4,
        case_title: "not fizz and buzz",
        input: 13,
        expected: "13"
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          # case_before c

          # -- given --
          fizz_buzz = FizzBuzz.new

          # -- when --
          actual = fizz_buzz.fizz_buzz c[:input]

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          # case_after c
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
~~~

Test Result
~~~bash
$rspec
Run options: include {:focus=>true}

All examples were filtered out; ignoring {:focus=>true}
....

Finished in 0.0045 seconds
4 examples, 0 failures
~~~

## Notice
* if you want to use field generation, you have to install 'tbpgr_utils' gem (ver >= 0.0.4).

## History
* version 0.0.8 : add field generation to product code.(using tbpgr_utils gem)
* version 0.0.7 : add product code generation option .delete unuse empty-line, unuse ret variable.
* version 0.0.6 : add class method generation.
* version 0.0.5 : add reportable option.
* version 0.0.4 : you can get multi level directory spec case.
* version 0.0.2 : fix bin.(use thor).
* version 0.0.1 : first release.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
