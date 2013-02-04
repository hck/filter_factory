require 'active_model'

module Filtr
  class Filter
    include ::ActiveModel

    attr_reader :fields

    def initialize
      @fields = []
    end

    def filled_fields
      fields.select{|f| !f.value.nil?}
    end

    private
    def field(name, condition)
      Field.new(name, condition).tap do |field|
        define_singleton_method(name){ field.value }
        define_singleton_method("#{name}="){|val| field.value = val }

        @fields << field
      end
    end

    def to_class(name)
      name_parts = name.split('::')
      name_parts.shift if name_parts.empty? || name_parts.first.empty?

      constant = Object
      name_parts.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end

      constant
    end

    class << self
      def create &block
        new.tap{|filter| filter.instance_eval &block}
      end
    end
  end
end