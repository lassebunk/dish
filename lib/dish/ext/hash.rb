class Hash
  def to_dish(klass = Dish::Plate)
    Dish(self, klass)
  end
end