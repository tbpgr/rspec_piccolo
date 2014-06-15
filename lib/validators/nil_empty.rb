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
        fail ArgumentError, format(PATH_NIL_MESSAGE, @key) if value.nil?
        fail ArgumentError, format(PATH_EMPTY_MESSAGE, @key) if value.empty?
      end
    end
  end
end
