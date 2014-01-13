module Dish
  class Plate
    def initialize(hash)
      hash.each do |key, value|
        dish_metaclass.send(:define_method, key) do
          dish_convert_value(value)
        end
      end
    end

    def method_missing(method, *args, &block)
      method = method.to_s
      if method.end_with?("?")
        field = method[0..-2]
        dish_check_for_presence(send(field))
      else
        nil
      end
    end

    private

      def dish_check_for_presence(value)
        !!value
      end

      def dish_convert_value(value)
        case value
        when Hash then self.class.new(value)
        when Array then value.map { |v| dish_convert_value(v) }
        else value
        end
      end

      def dish_metaclass
        class << self
          self
        end
      end
  end
end