require 'active_model'

module FilterFactory
  class Filter
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_reader :fields

    CONDITIONS = [:eq, :ne, :lt, :lte, :gt, :gte, :all, :in, :nin, :regex, :exists, :presents]

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

    def get_field(name)
      fields.find{|f| f.name == name}
    end

    def persisted?
      false
    end

    CONDITIONS.each do |condition|
      define_method condition do |name,options={}|
        field(name, condition, options)
      end
    end

    private
    def field(name, condition, options={})
      Field.new(name, condition, options).tap do |field|
        raise DuplicateFieldError if fields.include?(field)

        define_singleton_method(field.alias){ field.value }
        define_singleton_method("#{field.alias}="){|val| field.value = val }

        @fields << field
      end
    end

    class << self
      def create(&block)
        new.tap{|filter| filter.instance_eval &block}
      end
    end

    class DuplicateFieldError < StandardError; end
  end
end