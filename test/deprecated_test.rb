require "test_helper"

class DeprecatedTest < Test::Unit::TestCase
  def test_deprecated_as_hash
    p = Dish({ a: 1, b: 2 })

    out, err = capture_io do
      assert_equal({ "a" => 1, "b" => 2}, p.as_hash)
    end

    assert_match /Dish::Plate#as_hash has been deprecated\./, err
  end
end