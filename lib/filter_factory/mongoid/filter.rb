module FilterFactory
  module Mongoid
    # Filter module for MongoId to build relation for specified conditions
    module Filter
      # Applies the filter passed as an argument to model class or Mongoid::Criteria
      #
      # @param [Filter] filter_object filter object used to filter records
      # @return [Mongoid::Criteria]
      def filter(filter_object)
        conditions = filter_object.filled_fields.map do |field|
          FilterFactory::Mongoid::Condition.new(field.name, field.value).method(field.condition)
        end

        conditions.inject(self) do |res, condition|
          res.instance_eval(&condition)
        end
      end
    end
  end
end

if defined?(Mongoid::Document)
  Mongoid::Document.module_eval do
    def self.included(base)
      base.extend FilterFactory::Mongoid::Filter
    end
  end
end
