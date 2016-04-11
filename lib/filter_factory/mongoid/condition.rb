module FilterFactory
  module Mongoid
    class Condition < FilterFactory::Condition
      def eq(obj)
        obj.where(field_name => value)
      end

      def ne(obj)
        obj.where(field_name => { '$ne' => value })
      end

      def lt(obj)
        obj.where(field_name => { '$lt' => value })
      end

      def lte(obj)
        obj.where(field_name => { '$lte' => value })
      end

      def gt(obj)
        obj.where(field_name => { '$gt' => value })
      end

      def gte(obj)
        obj.where(field_name => { '$gte' => value })
      end

      def all(obj)
        obj.where(field_name => { '$all' => value })
      end

      def in(obj)
        obj.where(field_name => { '$in' => value })
      end

      def nin(obj)
        obj.where(field_name => { '$nin' => value })
      end

      def regex(obj)
        obj.where(field_name => /#{Regexp.escape(value)}/)
      end

      def exists(obj)
        obj.where(field_name => { '$exists' => value })
      end

      def presents(obj)
        operator = ['true', '1', 1].include?(value) ? '$nin' : '$in'
        obj.where(field_name => { operator => [nil, '', []] })
      end
    end
  end
end
