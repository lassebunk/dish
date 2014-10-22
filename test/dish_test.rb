require "test_helper"

class DishTest < Test::Unit::TestCase
  def test_conversion
    hash = {
      title: "My Title",
      authors: [
        { id: 1, name: "Mike Anderson" },
        { id: 2, name: "Well D." }
      ],
      active: false
    }

    book = Dish::Plate.new(hash)
    assert_equal "My Title", book.title
    assert_equal 2,          book.authors.length
    assert_equal "Well D.",  book.authors[1].name
    assert_equal true,       book.title?
    assert_equal false,      book.active
    assert_equal false,      book.active?
    assert_nil               book.other
    assert_equal false,      book.other?
    assert_respond_to book,  :title
    assert_respond_to book,  :authors
    refute_respond_to book,  :doesnotexist
    assert_nothing_raised do
      book.method(:title)
    end
  end

  def test_key_type_indifference
    hash = {
      "title" => "My Title",
      "authors" => [
        { "id" => 1, "name" => "Mike Anderson" },
        { "id" => 2, "name" => "Well D." }
      ],
      "active" => false
    }

    book = Dish::Plate.new(hash)
    assert_equal "My Title", book.title
    assert_equal 2,          book.authors.length
    assert_equal "Well D.",  book.authors[1].name
    assert_equal true,       book.title?
    assert_equal false,      book.active
    assert_equal false,      book.active?
  end

  def test_hash_helper
    hash = { a: 1, b: 2 }
    dish = Dish(hash)
    assert_instance_of Dish::Plate, dish
    assert_equal 2, dish.b
  end

  def test_array_helper
    array = [
      { a: 1, b: 2 },
      { c: 3, d: 4 }
    ]
    dish = Dish(array)
    assert_instance_of Array, dish
    assert_equal 2, dish.length
    dish.each do |d|
      assert_instance_of Dish::Plate, d
    end
  end

  def test_using_helper_on_other_types
    assert_instance_of String, Dish("test")
    assert_instance_of Fixnum, Dish(3)
    assert_nil Dish(nil)
  end

  def test_to_h
    hash = {
      "a" => "a",
      "b" => "b",
      "c" => {
        "1" => 1,
        "2" => 2
      }
    }
    dish = Dish(hash)
    c_hash = dish.c.to_h
    assert_equal "Hash", dish.c.to_h.class.to_s
    assert_equal hash["c"]["1"], c_hash["1"]
    assert_equal hash["c"]["2"], c_hash["2"]
  end

  def test_hash_ext
    hash = { a: 1, b: 2 }
    dish = hash.to_dish
    assert_instance_of Dish::Plate, dish
  end

  def test_array_ext
    array = [
      { a: 1, b: 2 },
      { c: 3, d: 4 }
    ]
    dish = array.to_dish
    assert_instance_of Array, dish
    assert_equal 2, dish.length
    dish.each do |d|
      assert_instance_of Dish::Plate, d
    end
  end

  def test_respond_to
    hash = { a: 1, b: true, c: false, d: nil }
    dish = Dish(hash)

    hash.each do |key, _|
      assert_respond_to dish, key
    end
  end

  def test_set_value
    hash = { a: 1, b: 2, c: false }
    dish = Dish(hash)

    dish.a = "other value"
    assert_equal "other value", dish.a
    
    dish.b = nil
    assert_equal nil, dish.b
    assert_equal false, dish.b?

    dish.c = true
    assert_equal true, dish.c
    assert_equal true, dish.c?

    dish.d = "new value"
    assert_equal "new value", dish.d

    assert_equal({ "a" => "other value", "b" => nil, "c" => true, "d" => "new value" },
                 dish.to_h)
  end

  def test_methods
    hash = { a: 1, b: 2 }
    dish = Dish(hash)

    assert_equal [:a, :b], dish.methods[0..1]
  end
end