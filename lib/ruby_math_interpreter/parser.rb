module RubyMathInterpreter
  class Parser
    def self.call(tokens)
      new(tokens).call
    end

    def initialize(tokens)
      @tokens = tokens
    end

    def call
      program
    end

    def program
      term
    end

    def term
      expr = number

      while matches?("+", "-")
        operator = advance
        expr2 = number

        expr = {type: :binary, operator:, left: expr, right: expr2}
      end

      expr
    end

    def number
      token = advance
      raise "EOF" if token.nil?
      if !token.match?(/\d/)
        raise "Expected an expression, got '#{token}'"
      end

      {type: :number, value: token.to_i}
    end

    private

    def matches?(*types)
      types.any? { it === @tokens.first }
    end

    def advance
      @tokens.shift
    end
  end
end
