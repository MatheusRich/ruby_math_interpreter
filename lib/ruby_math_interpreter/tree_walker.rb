module RubyMathInterpreter
  module TreeWalker
    def self.call(code)
      tokenize(code)
        .then { parse(it) }
        .then { interpret(it) }
    end

    def self.tokenize(code) = Tokenizer.call(code)

    def self.parse(tokens) = Parser.call(tokens)

    def self.interpret(ast)
      case ast[:type]
      in :number
        ast[:value]
      in :binary
        left = interpret(ast[:left])
        right = interpret(ast[:right])

        left.send(ast[:operator], right)
      end
    end
  end
end
