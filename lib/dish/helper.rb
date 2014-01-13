def Dish(hash_or_array)
  case hash_or_array
  when Hash then Dish::Plate.new(hash_or_array)
  when Array then hash_or_array.map { |v| Dish(v) }
  else hash_or_array
  end
end