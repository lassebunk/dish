[![Build Status](https://secure.travis-ci.org/lassebunk/dish.png)](http://travis-ci.org/lassebunk/dish)

# Dish!

![Dish](http://i.imgur.com/FP1DJmt.png)

Very simple conversion of hashes to plain Ruby objects.
This is great for consuming JSON API's which is what I use it for.

## Installation

Add this line to your application's *Gemfile*:

    gem "dish"

Then run:

    $ bundle

Or install it yourself:

    $ gem install dish

If you want a `to_dish` helper method added to your Hash and Array objects, you can require `dish/ext` in your *Gemfile*:

    gem "dish", require: "dish/ext"

### Installation in RubyMotion

Dish fully supports [RubyMotion](http://www.rubymotion.com/), enabling you to easily consume JSON API's in your Ruby iOS apps.

For installation in RubyMotion, add this line to your project's *Gemfile*:

    gem "dish", require: "dish/motion"

Then run:

    $ bundle

And you're good to go.

Note: If you're using Dish with the BubbleWrap JSON module, please see below.

# Example

    hash = {
      title: "My Title",
      authors: [
        { id: 1, name: "Mike Anderson" },
        { id: 2, name: "Well D." }
      ],
      active: false
    }

    book = Dish(hash) # or hash.to_dish if you required "dish/ext"
    book.title           # => "My Title"
    book.authors.length  # => 2
    book.authors[1].name # => "Well D."
    book.title?          # => true
    book.active?         # => false
    book.other           # => nil
    book.other?          # => false

## Notes

### Using with the BubbleWrap JSON module

When you use the [BubbleWrap](https://github.com/rubymotion/BubbleWrap) gem to parse JSON into a hash, you can't use the
`to_dish` methods directly because the `BW::JSON` module returns some sort of hash that hasn't got the methods from the real hash. I'm
fixing this, but in the meanwhile you can achieve the same result by doing this:

    BW::HTTP.get("http://path.to/api/books/2") do |response|
      json = BW::JSON.parse(response.body.to_s)
      book = Dish(json) # This is the actual conversion

      title_label.text = book.title
      author_label.text = book.authors.map(&:name).join(", ")
    end

## Contributing

Feature additions are very welcome, but please submit an issue first, so we can discuss it in advance. Thanks.

1. Fork the project
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Make your changes, including tests so it doesn't break in the future
4. Commit your changes (`git commit -am 'Add feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new pull request
