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
      in :unary
        case ast[:operator]
        in "-"
          right = interpret(ast[:right])
          right.send(:"#{ast[:operator]}@")
        in "!"
          right = interpret(ast[:right])
          factorial(right)
        end
      in :binary
        left = interpret(ast[:left])
        right = interpret(ast[:right])

        left.send(ast[:operator], right)
      end
    end

    private_class_method def self.factorial(n)
      return 1 if n <= 1
      n * factorial(n - 1)
    end
  end
end
