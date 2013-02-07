require 'active_model'

module FilterFactory
  class Filter
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :fields

    def initialize
      @fields = []
    end

    def attributes
      @fields.inject(HashWithIndifferentAccess.new) do |acc,field|
        acc[field.alias] = field.value
        acc
      end
    end

    def attributes=(attributes = {})
      return unless attributes
      attributes.each do |name, value|
        public_send("#{name}=", value)
      end
    end

    def filled_fields
      fields.select{|f| !f.value.nil? && f.value != ''}
    end

    def persisted?
      false
    end

    private
    def field(name, condition, options={})
      Field.new(name, condition, options).tap do |field|
        define_singleton_method(field.alias){ field.value }
        define_singleton_method("#{field.alias}="){|val| field.value = val }

        @fields << field
      end
    end

    class << self
      def create &block
        new.tap{|filter| filter.instance_eval &block}
      end
    end
  end
end