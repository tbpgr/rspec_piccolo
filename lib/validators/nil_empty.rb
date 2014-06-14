module RSpecPiccolo
  # Validators
  module Validators
    # ClassPath
    class NilEmpty
      PATH_NIL_MESSAGE = '%s is not allowed nil value'
      PATH_EMPTY_MESSAGE = '%s is not allowed empty value'

      def initialize(key)
        @key = key
      end

      def validate(value)
        fail ArgumentError.new(format(PATH_NIL_MESSAGE, @key)) if value.nil?
        if value.empty?
          fail ArgumentError.new(format(PATH_EMPTY_MESSAGE, @key))
        end
      end
    end
  end
end
