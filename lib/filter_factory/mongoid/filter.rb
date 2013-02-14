module FilterFactory
  module Mongoid
    module Filter
      def filter(filter_object)
        conditions = filter_object.filled_fields.map do |field|
          FilterFactory::Mongoid::Condition.new(field.name, field.value).method(field.condition)
        end

        conditions.inject(self) do |res,condition|
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