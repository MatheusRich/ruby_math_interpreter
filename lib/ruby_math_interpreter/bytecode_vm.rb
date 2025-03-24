module RubyMathInterpreter
  module Compiler
    def self.call(ast)
      instructions = []

      case ast[:type]
      in :number
        instructions += [[:putobject, ast[:value]]]
      in :unary
        case ast[:operator]
        in "-"
          instructions += call(ast[:right])
          instructions += [[:sendself, ast[:operator]]]
        in "!"
          instructions += call(ast[:right])
          instructions += [[:factorial]]
        end
      in :binary
        instructions += call(ast[:left])
        instructions += call(ast[:right])
        instructions += [[:send, ast[:operator]]]
      in :application
        ast => {operator:, from:, to:}
        instructions += call(from)
        instructions += call(to)
        instructions += [[:putobject, operator]]
        instructions += [[:apply]]
      end

      instructions
    end
  end

  module VM
    def self.call(instructions)
      stack = []

      instructions.each do |instruction|
        case instruction
        in [:putobject, value]
          stack.push(value)
        in [:sendself, operator]
          right = stack.pop
          result = right.send(:"#{operator}@")
          stack.push(result)
        in [:send, operator]
          right = stack.pop
          left = stack.pop
          result = left.send(operator, right)
          stack.push(result)
        in [:factorial]
          value = stack.pop
          result = factorial(value)
          stack.push(result)
        in [:apply]
          operator = stack.pop
          to = stack.pop
          from = stack.pop
          raise "Invalid range" if from.is_a?(Float) || to.is_a?(Float)

          by = to < from ? -1 : 1
          result = from.step(to:, by:).reduce(operator)
          stack.push(result)
        end
      end

      stack.pop
    end

    private_class_method def self.factorial(n)
      return 1 if n <= 1
      n * factorial(n - 1)
    end
  end

  module BytecodeVm
    def self.call(code)
      tokenize(code)
        .then { parse(it) }
        .then { compile(it) }
        .then { run(it) }
    end

    def self.tokenize(code) = Tokenizer.call(code)

    def self.parse(tokens) = Parser.call(tokens)

    def self.compile(ast) = Compiler.call(ast)

    def self.run(bytecode) = VM.call(bytecode)
  end
end
