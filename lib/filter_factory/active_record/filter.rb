module FilterFactory
  module ActiveRecord
    module Filter
      # Applies the filter passed as an argument to model class or relation
      #
      # @param [Filter] filter_object filter object used to filter records
      # @return [ActiveRecord::Relation]
      def filter(filter_object)
        conditions = filter_object.filled_fields.map do |field|
          FilterFactory::ActiveRecord::Condition.new(field.name, field.value).method(field.condition)
        end

        relation = is_a?(::ActiveRecord::Relation) ? self : nil

        conditions.inject(relation) do |res, condition|
          res ? res.instance_eval(&condition) : instance_eval(&condition)
        end
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send(:extend, FilterFactory::ActiveRecord::Filter)
end
