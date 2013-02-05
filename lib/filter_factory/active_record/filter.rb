module FilterFactory
  module ActiveRecord
    module Filter
      def filter(filter_object)
        conditions = filter_object.filled_fields.map do |field|
          FilterFactory::ActiveRecord::Condition.new(field.name, field.value).method(field.condition)
        end

        conditions.inject(nil) do |res,condition|
          res ? res.instance_eval(&condition) : instance_eval(&condition)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:extend, FilterFactory::ActiveRecord::Filter) if defined?(ActiveRecord::Base)