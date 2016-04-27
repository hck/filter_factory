module FilterFactory
  # Class for difining filter condition for a particular field
  class Field
    attr_reader :name, :condition, :alias, :options
    attr_accessor :value

    # Initializes new instance of Field.
    #
    # @param [Symbol, String] name
    # @param [Symbol] condition
    # @param [Hash] options
    # @option options [Symbol, String] :alias field alias
    def initialize(name, condition, options = {})
      raise ArgumentError unless FilterFactory::Filter::CONDITIONS.include?(condition)

      valid_options = [:alias]
      @name = name
      @condition = condition
      @options = options.select { |k,| valid_options.include?(k) }
      @alias = @options[:alias] || @name
    end

    # Checks whether two objects are equal.
    # Returns true if obj is of the same class and has name,
    # condition and alias attributes equal to current object.
    #
    # @param [Object] obj object to compare with
    # @return [Boolean]
    def ==(other)
      return false unless other.is_a?(self.class)

      [:name, :condition, :alias].inject(true) do |acc, attr|
        acc && public_send(attr) == other.public_send(attr)
      end
    end
  end
end
