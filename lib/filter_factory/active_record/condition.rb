module FilterFactory
  module ActiveRecord
    # Implementation of filtering conditions for ActiveRecord
    class Condition < FilterFactory::Condition
      def eq(obj)
        obj.where(field_name => value)
      end

      def ne(obj)
        obj.where("#{field_name} != ?", value)
      end

      def lt(obj)
        obj.where("#{field_name} < ?", value)
      end

      def lte(obj)
        obj.where("#{field_name} <= ?", value)
      end

      def gt(obj)
        obj.where("#{field_name} > ?", value)
      end

      def gte(obj)
        obj.where("#{field_name} >= ?", value)
      end

      def all(_obj)
        raise NotImplementedError, 'all operator is not available for ActiveRecord'
      end

      def is_in(obj)
        obj.where("#{field_name} IN (?)", value)
      end

      def not_in(obj)
        obj.where("#{field_name} NOT IN (?)", value)
      end

      def regex(obj)
        obj.where("#{field_name} REGEXP ?", Regexp.escape(value))
      end

      def exists(_obj)
        raise NotImplementedError, 'exists operator is not available for ActiveRecord'
      end

      def presents(obj)
        obj.where("(#{field_name} IS NOT NULL) = ?", value)
      end
    end
  end
end
