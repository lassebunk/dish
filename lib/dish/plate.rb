module Dish
  class Plate
    def initialize(hash)
      @_dish_original_hash = Hash[hash.map { |k, v| [k.to_s, v] }]
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      if method.end_with?("?")
        key = method[0..-2]
        _dish_check_for_presence(key)
      else
        _dish_get_value(method)
      end
    end

    def as_hash
      @_dish_original_hash
    end

    private

      attr_reader :_dish_original_hash

      def _dish_get_value(key)
        value = _dish_original_hash[key]
        _dish_convert_value(value)
      end

      def _dish_check_for_presence(key)
        !!_dish_get_value(key)
      end

      def _dish_convert_value(value)
        case value
        when Hash then self.class.new(value)
        when Array then value.map { |v| _dish_convert_value(v) }
        else value
        end
      end
  end
end