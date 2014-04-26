# matchrb

**matchrb** (pronounced 'matcherby') provides a simple but powerful way to do
pattern matching in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'matchrb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matchrb

## Usage

`matchrb` implements two methods, `#match` and `#otherwise`. You can use them
globaly like so:

```ruby
require 'matchrb/global'

object = 100
match object,
  String    => "object is a string",
  Integer   => "object is an integer",
  otherwise => "object is...just an object"
```

or, to avoid name clashes, use them individually:

```ruby
require 'matchrb'

object = 100
Matchrb.match object,
  String            => "object is a string",
  Integer           => "object is an integer",
  Matchrb.otherwise => "object is...just an object"
```

That's it!

## Contributing

1. Fork it ( https://github.com/dlisboa/matchrb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
