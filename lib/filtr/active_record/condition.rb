module Filtr
  module ActiveRecord
    class Condition < Filtr::Condition
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

      def all(obj)
        raise NotImplementedError, "all operator is not available for ActiveRecord"
      end

      def in(obj)
        obj.where("#{field_name} IN (?)", value)
      end

      def nin(obj)
        obj.where("#{field_name} NOT IN (?)", value)
      end

      def regex(obj)
        obj.where("#{field_name} REGEXP ?", value)
      end

      def exists(obj)
        raise NotImplementedError, "all operator is not available for ActiveRecord"
      end

      def present(obj)
        obj.where("(#{field_name} IS NOT NULL) = ?", value)
      end
    end
  end
end