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
      in :application
        ast => {operator:, from:, to:}
        from_value = interpret(from)
        raise "Invalid range" if from_value.is_a? Float

        to_value = interpret(to)
        raise "Invalid range" if to_value.is_a? Float

        by = to_value < from_value ? -1 : 1
        from_value.step(to_value, by).reduce(operator)
      end
    end

    private_class_method def self.factorial(n)
      return 1 if n <= 1
      n * factorial(n - 1)
    end
  end
end
