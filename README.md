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
~~~
piccolo execute SomeClass some_class_place
~~~

Result, spec/some_class_place
~~~
# encoding: utf-8
require "spec_helper"
require "some_class_place"

describe SomeClass do

end
~~~

### Case module_name + class_name, directory_name + class_place
~~~
piccolo execute SomeModule::SomeClass some_directory/some_class_place
~~~

Result, spec/some_directory/some_class_place
~~~
# encoding: utf-8
require "spec_helper"
require "some_directory/some_class_place"

describe SomeModule::SomeClass do

end
~~~

### Case class_name, class_place, method_names
~~~
piccolo execute SomeClass some_class_place method1 method2
~~~

Result, spec/some_class_place
~~~
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

## Pragmatic Usase
You can edit your spec template like this sample.

This sample, you create fizzbuzz application.

If your product-code is ...

lib/fizz_buzz.rb
~~~
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
~~~
rspec --init
~~~

You generate concrete spec by piccolo.
~~~
piccolo execute FizzBuzz fizz_buzz fizz_buzz
~~~

Generated spec is ...

spec/fizz_buzz_spec.rb
~~~
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
~~~
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
~~~
$rspec
Run options: include {:focus=>true}

All examples were filtered out; ignoring {:focus=>true}
....

Finished in 0.0045 seconds
4 examples, 0 failures
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
