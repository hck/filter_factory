module FilterFactory
  class Condition
    attr_reader :field_name, :value

    def initialize(field_name, value)
      @field_name, @value = field_name, value
    end
  end
end