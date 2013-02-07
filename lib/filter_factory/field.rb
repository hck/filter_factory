module FilterFactory
  class Field
    attr_reader :name, :condition, :alias, :options
    attr_accessor :value

    def initialize(name, condition, options = {})
      valid_options = [:alias]
      @name, @condition, @options = name, condition, options.reject{|k,v| !valid_options.include?(k)}
      @alias = @options[:alias] || @name
    end
  end
end