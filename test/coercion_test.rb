require "test_helper"
require "time" # for Time.parse in Ruby 1.9.3

class DishTest < Test::Unit::TestCase
  def test_coercion
    product = Dish(api_response.first, Product)

    assert_equal Time.new(2013, 1, 28, 13, 23, 11), product.updated_at
    assert product.authors.all? { |a| a.is_a? Author }
    assert_equal ["First Author", "Second Author"], product.authors.map(&:name)
  end

  def test_hash_helper_coercion
    product = api_response.first.to_dish(Product)

    assert_equal Time.new(2013, 1, 28, 13, 23, 11), product.updated_at
    assert product.authors.all? { |a| a.is_a? Author }
    assert_equal ["First Author", "Second Author"], product.authors.map(&:name)
  end

  def test_array_coercion
    products = Dish(api_response, Product)

    assert products.all? { |p| p.is_a?(Product) }
    assert products.map(&:authors).flatten.all? { |a| a.is_a?(Author) }
  end

  def test_array_helper_coercion
    products = api_response.to_dish(Product)

    assert products.all? { |p| p.is_a?(Product) }
    assert products.map(&:authors).flatten.all? { |a| a.is_a?(Author) }
  end

  private

    class Author < Dish::Plate; end

    class Product < Dish::Plate
      coerce :updated_at, ->(value) { Time.parse(value) }
      coerce :authors, Author
    end

    def api_response
      [
        {
          title: "Test Product",
          updated_at: "2013-01-28 13:23:11",
          authors: [
            { id: 1, name: "First Author" },
            { id: 2, name: "Second Author" }
          ]
        },
        {
          title: "Second Product",
          updated_at: "2012-07-11 19:54:07",
          authors: [
            { id: 1, name: "Third Author" },
            { id: 2, name: "Fourth Author" }
          ]
        }
      ]
    end
end