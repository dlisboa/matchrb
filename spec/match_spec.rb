$:.unshift File.expand_path("../../lib", __FILE__)

require "minitest/autorun"
require "minitest/spec"

require "matchrb/global"

describe "match" do
  describe "when the pattern is a class" do
    it "matches the kind of the object" do
      Foo = Class.new
      foo = Foo.new

      result = match foo,
        Foo => "foo is Foo"

      result.must_equal "foo is Foo"
    end
  end

  describe "when the pattern is a Regexp" do
    it "matches the regex against the object" do
      result = match "this is a string",
        /this is not a string/ => false,
        /this is a.*/ => true

      result.must_equal true
    end
  end

  describe "when no pattern is matched" do
    it "returns nil" do
      result = match "this is a string",
        Integer => false,
        Class => true

      result.must_equal nil
    end
  end

  describe "when the action is an object" do
    it "returns that object" do
      someobject = Object.new

      result = match 1,
        Integer => someobject

      result.object_id.must_equal someobject.object_id
    end
  end

  describe "when the action is a :to_proc'able object" do
    it "returns the result of calling that object" do
      Identity = Class.new do
        def initialize(number)
          @number = number
        end

        def to_proc
          -> { @number }
        end
      end

      result = match 1,
        Integer => Identity.new(10)

      result.must_equal 10
    end
  end

  describe "when an `otherwise' pattern is given" do
    it "matches that pattern if no other is matched before" do
      result = match "this is a string",
        666 => true,
        /the quick brown fox/ => false,
        otherwise => "none matched"

      result.must_equal "none matched"
    end

    it "matches more specific patterns before that" do
      result = match "this is a string",
        String => true,
        Class => false,
        otherwise => "none matched"

      result.must_equal true
    end
  end

  it "matches any predicate if it returns true for that object" do
    Twice = Class.new do
      def self.===(object)
        object % 2 == 0
      end
    end

    number = 21 * 2

    result = match number,
      Twice => "it's twice something"

    result.must_equal "it's twice something"
  end

  describe "when passed an 'extractor'" do
    it "it calls the action with the extracted value" do
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

      number = 99

      result = match number,
        Multiple.of(3) => ->(value) { value }

      result.must_equal 33
    end
  end

  describe "when used as control flow" do
    it "returns from outer context when using `proc'" do
      def foobar
        match 1,
          Integer => proc { return 666 }

        10
      end

      foobar.must_equal 666
    end
  end
end

