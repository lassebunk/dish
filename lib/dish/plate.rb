module Dish
  class Plate
    def initialize(hash)
      @dish_original_hash = Hash[hash.map { |k, v| [k.to_s, v] }]
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      if method.end_with?("?")
        key = method[0..-2]
        dish_check_for_presence(key)
      else
        dish_get_value(method)
      end
    end

    def as_hash
      @dish_original_hash
    end

    private

      attr_reader :dish_original_hash

      def dish_get_value(key)
        value = dish_original_hash[key]
        dish_convert_value(value)
      end

      def dish_check_for_presence(key)
        !!dish_get_value(key)
      end

      def dish_convert_value(value)
        case value
        when Hash then self.class.new(value)
        when Array then value.map { |v| dish_convert_value(v) }
        else value
        end
      end
  end
end