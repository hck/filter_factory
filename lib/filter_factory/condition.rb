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

    def eq(_obj)
      fail NotImplementedError
    end

    def ne(_obj)
      fail NotImplementedError
    end

    def lt(_obj)
      fail NotImplementedError
    end

    def lte(_obj)
      fail NotImplementedError
    end

    def gt(_obj)
      fail NotImplementedError
    end

    def gte(_obj)
      fail NotImplementedError
    end

    def all(_obj)
      fail NotImplementedError
    end

    def is_in(_obj)
      fail NotImplementedError
    end

    def not_in(_obj)
      fail NotImplementedError
    end

    def regex(_obj)
      fail NotImplementedError
    end

    def exists(_obj)
      fail NotImplementedError
    end

    def presents(_obj)
      fail NotImplementedError
    end
  end
end
