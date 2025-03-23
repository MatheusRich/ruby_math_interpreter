module RubyMathInterpreter
  module Tokenizer
    def self.call(input)
      input.scan(%r{[A-Za-z0-9]+|[.+\-*/=()!]})
    end
  end
end
