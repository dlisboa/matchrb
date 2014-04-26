# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matchrb/version'

Gem::Specification.new do |spec|
  spec.name          = "matchrb"
  spec.version       = Matchrb::VERSION
  spec.authors       = ["Diogo Lisboa"]
  spec.email         = ["diogoslisboa@gmail.com"]
  spec.summary       = %q{A tiny play on pattern matching in Ruby.}
  spec.description   = <<-EOS
    matchrb (pronounced 'matcherby') provides a simple but powerful way to do
    pattern matching in Ruby.
  EOS
  spec.homepage      = "https://github.com/dlisboa/matchrb"
  spec.license       = "BSD"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{spec})
  spec.require_paths = ["lib"]
end
