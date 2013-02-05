module FilterFactory
  class Field
    attr_reader :name, :condition, :options
    attr_accessor :value

    def initialize(name, condition, options = {})
      @name, @condition, @options = name, condition, options
    end
  end
end