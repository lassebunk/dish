module Dish
  class Plate
    class << self
      def coercions
        @coercions ||= Hash.new(Plate)
      end

      def coerce(key, klass_or_proc)
        coercions[key.to_s] = klass_or_proc
      end
    end

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
        _dish_convert_value(value, self.class.coercions[key])
      end

      def _dish_check_for_presence(key)
        !!_dish_get_value(key)
      end

      def _dish_convert_value(value, coercion)
        case value
        when Array then value.map { |v| _dish_convert_value(v, coercion) }
        when Hash
          if coercion.is_a?(Proc)
            coercion.call(value)
          else
            coercion.new(value)
          end
        else
          if coercion.is_a?(Proc)
            coercion.call(value)
          else
            value
          end
        end
      end
  end
end