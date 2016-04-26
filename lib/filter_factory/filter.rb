require 'active_model'
require 'active_support/hash_with_indifferent_access'

module FilterFactory
  class Filter
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :fields

    CONDITIONS = [
      :eq, :ne, :lt, :lte, :gt, :gte, :all,
      :is_in, :not_in, :regex, :exists, :presents
    ].freeze

    # Initializes new instance of Filter class.
    def initialize
      @fields = []
    end

    # Returns list of filter attributes.
    #
    # @return [HashWithIndifferentAccess]
    def attributes
      fields.each_with_object(HashWithIndifferentAccess.new) do |field, acc|
        acc[field.alias] = field.value
      end
    end

    # Assigns values to filter's attributes.
    #
    # @param [Hash] attributes hash of new attributes' values
    def attributes=(attributes = {})
      return unless attributes
      attributes.each do |name, value|
        public_send("#{name}=", value)
      end
    end

    # Returns list of filled fields.
    # Field is considered to be filled if it's value is not nil
    # and is not an empty string.
    # @return [Array<Field>]
    def filled_fields
      fields.select { |f| !f.value.nil? && f.value != '' }
    end

    # Returns field by its name.
    #
    # @param [Symbol, String] name name of the field
    # @return [Field, nil]
    def get_field(name)
      fields.find { |f| f.name == name }
    end

    # Required by ActiveModel.
    # May be removed in newer Rails versions.
    #
    # @returns [Boolean] true
    def persisted?
      false
    end

    CONDITIONS.each do |condition|
      define_method(condition) do |name, options = {}|
        field(name, condition, options)
      end
    end

    class << self
      # Creates a new filter instance and executes block on it
      #
      # @param [Proc] block block to be executed in context of new filter instance
      # @return [Filter]
      def create(&block)
        new.tap { |filter| filter.instance_eval(&block) }
      end
    end

    # Error class which represents error when filter already has the same field defined.
    class DuplicateFieldError < StandardError
    end

    private

    def field(name, condition, options = {})
      Field.new(name, condition, options).tap do |field|
        raise DuplicateFieldError if fields.include?(field)

        define_singleton_method(field.alias) { field.value }
        define_singleton_method("#{field.alias}=") { |val| field.value = val }

        @fields << field
      end
    end
  end
end
