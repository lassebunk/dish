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
      @_original_hash = Hash[hash.map { |k, v| [k.to_s, v] }]
      @_value_cache = {}
    end

    def hash
      to_h.hash
    end

    def ==(other)
      return false unless other.respond_to?(:to_h)
      to_h == other.to_h
    end

    alias :eql? :==

    def method_missing(method, *args, &block)
      method = method.to_s
      key = method[0..-2]
      if method.end_with?("?")
        !!_get_value(key)
      elsif method.end_with? '='
        _set_value(key, args.first)
      else
        _get_value(method)
      end
    end

    def respond_to_missing?(method, *args)
      _check_for_presence(method.to_s) || super
    end

    def to_h
      @_original_hash
    end

    def as_hash
      # TODO: Add the version number where this was deprecated?
      warn 'Dish::Plate#as_hash has been deprecated. Use Dish::Plate#to_h.'
      to_h
    end

    def to_json(*args)
      # If we're using RubyMotion #to_json isn't available like with Ruby's JSON stdlib
      if defined?(Motion::Project::Config)
        # From BubbleWrap: https://github.com/rubymotion/BubbleWrap/blob/master/motion/core/json.rb#L30-L32
        NSJSONSerialization.dataWithJSONObject(to_h, options: 0, error: nil).to_str
      elsif defined?(JSON)
        to_h.to_json(*args)
      else
        raise "#{self.class}#to_json depends on Hash#to_json. Try again after using `require 'json'`."
      end
    end

    def methods(regular = true)
      valid_keys = to_h.keys.map(&:to_sym)
      valid_keys + super
    end

    private

      attr_reader :_original_hash

      def _get_value(key)
        value = _original_hash[key]
        @_value_cache[_cache_key(value)] ||= _convert_value(value, self.class.coercions[key])
      end

      def _cache_key(value)
        [value.object_id, @_original_hash.hash].join('')
      end

      def _set_value(key, value)
        @_original_hash[key] = value
      end
 
      def _check_for_presence(key)
        _original_hash.key?(key)
      end

      def _convert_value(value, coercion)
        case value
        when Array then value.map { |v| _convert_value(v, coercion) }
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
