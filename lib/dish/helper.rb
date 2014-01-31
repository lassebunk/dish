def Dish(hash_or_array, klass = Dish::Plate)
  case hash_or_array
  when Hash then klass.new(hash_or_array)
  when Array then hash_or_array.map { |v| Dish(v, klass) }
  else hash_or_array
  end
end