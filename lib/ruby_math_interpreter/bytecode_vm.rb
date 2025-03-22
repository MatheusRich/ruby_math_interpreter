module RubyMathInterpreter
  module Compiler
    def self.call(ast)
      instructions = []

      case ast[:type]
      in :number
        instructions += [[:putobject, ast[:value]]]
      in :binary
        instructions += call(ast[:left])
        instructions += call(ast[:right])
        instructions += [[:send, ast[:operator]]]
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
        in [:send, operator]
          right = stack.pop
          left = stack.pop
          result = left.send(operator, right)
          stack.push(result)
        end
      end

      stack.pop
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
