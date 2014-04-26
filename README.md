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

**matchrb** implements two methods, `#match` and `#otherwise`. You can use them
globaly like so:

```ruby
require 'matchrb/global'

object = 100
match object,
  String    => "object is a string",
  Integer   => "object is an integer",
  otherwise => "object is...just an object"
# => "object is an integer"
```

or, to avoid name clashes, use them individually:

```ruby
require 'matchrb'

object = 100

Matchrb.match object,
  String            => "object is a string",
  Integer           => "object is an integer",
  Matchrb.otherwise => "object is...just an object"
# => "object is an integer"
```

It also has some functionality akin to extractors in Scala. All you have to do
is return some object from `#===`.

```ruby
Multiple = Class.new do
  def self.of(number)
    new(number)
  end

  def initialize(number)
    @number = number
  end

  def ===(object)
    object % @number == 0 ? object/@number : false
  end
end

match 99,
  Multiple.of(3) => ->(value) { value }
#=> 33
```

It's not as powerful, though: you can't return a falsy value. The
implementation is too simple as of yet.

## TODO

* Proper objects for matching, instead of relying on truthy/falsy values
  (perhaps Some/None). With this you can return `nil` or `false` from the
  matcher and have it used by the `lambda`/`proc` on the right hand side.

* Yielding of matched value to any callable, not just extractors. With this
  you can do things like:
  ```ruby
  class Multiplier
    def initialize(by)
      @by = by
    end

    def to_proc
      method(:call)
    end

    def call(value)
      value * @by
    end
  end

  match 10,
    Integer => Multiplier.new(10)
  #=> 100
  ```

* Lots of other proper matching idioms.

## Contributing

1. Fork it ( https://github.com/dlisboa/matchrb/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

(The BSD License)

Copyright (c) 2014 Diogo Lisboa

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or
other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
