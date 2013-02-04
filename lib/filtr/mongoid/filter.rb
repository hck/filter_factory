module Filtr
  module Mongoid
    module Filter
      def filter(filter_object)
        conditions = filter_object.filled_fields.map do |field|
          Filtr::Mongoid::Condition.new(field.name, field.value).method(field.condition)
        end

        conditions.inject(nil) do |res,condition|
          res ? res.instance_eval(&condition) : instance_eval(&condition)
        end || self
      end
    end
  end
end

if defined?(Mongoid::Document)
  Mongoid::Document.module_eval do
    def self.included(base)
      base.extend Filtr::Mongoid::Filter
    end
  end
end