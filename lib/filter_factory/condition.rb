module FilterFactory
  class Condition
    attr_reader :field_name, :value

    # Initializes new instance of Condition class.
    #
    # @param [Symbol] field_name field name which will be used in condition
    # @param [Object] value value which will be used in condition
    def initialize(field_name, value)
      @field_name, @value = field_name, value
    end

    # Adds condition to fetch filtered entries where field value is equal to
    # filter's value.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def eq(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is not equal
    # to filter's value.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def ne(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is less than
    # filter's value.
    #
    # @param [Object] _obj
    def lt(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is less than
    # or equal than filter's value.
    #
    # @param [Object] _obj
    def lte(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is greater than
    # filter's value.
    #
    # @param [Object] _obj
    def gt(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is greater than
    # or equal than filter's value.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def gte(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is an array
    # and it contains all elements in array specified in the filter for
    # appropriate field.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def all(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is in the list.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def is_in(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is not in the list.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def not_in(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where field value is matched
    # by reqular expression.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def regex(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries where particular field exists.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def exists(_obj)
      fail NotImplementedError
    end

    # Adds condition to fetch filtered entries.
    # Should be implemented in subclasses.
    #
    # @param [Object] _obj
    def presents(_obj)
      fail NotImplementedError
    end
  end
end
