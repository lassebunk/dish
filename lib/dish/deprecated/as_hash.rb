Dish::Plate.class_eval do
  def as_hash
    warn "Dish::Plate#as_hash is deprecated. Please use `to_h` instead."
    to_h
  end
end