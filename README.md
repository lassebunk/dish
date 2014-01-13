# Dish!

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

## Contributing

Feature additions are very welcome, but please submit an issue first, so we can discuss it in advance. Thanks.

1. Fork the project
2. Create a feature branch (`git checkout -b my-new-feature`)
3. Make your changes, including tests so it doesn't break in the future
4. Commit your changes (`git commit -am 'Add feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new pull request
