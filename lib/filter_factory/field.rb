module FilterFactory
  class Field
    attr_reader :name, :condition, :alias, :options
    attr_accessor :value

    def initialize(name, condition, options = {})
      raise ArgumentError unless FilterFactory::Filter::CONDITIONS.include?(condition)

      valid_options = [:alias]
      @name, @condition, @options = name, condition, options.reject{|k,| !valid_options.include?(k)}
      @alias = @options[:alias] || @name
    end

    def ==(obj)
      return false unless obj.is_a?(self.class)
      [:name, :condition, :alias].inject(true) do |acc,attr|
        acc && public_send(attr) == obj.public_send(attr)
      end
    end
  end
end