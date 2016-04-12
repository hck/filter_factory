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
  end
end
