module RubyMathInterpreter
  class Parser
    KEYWORDS = {
      "pi" => Math::PI,
      "e" => Math::E,
    }.freeze

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
      expr = factor

      while matches?("+", "-")
        operator = advance
        expr2 = factor

        expr = {type: :binary, operator:, left: expr, right: expr2}
      end

      expr
    end

    def factor
      expr = unary

      while matches?("*", "/")
        operator = advance
        expr2 = unary

        expr = {type: :binary, operator:, left: expr, right: expr2}
      end

      expr
    end

    def unary
      if matches?("-")
        operator = advance
        right = unary

        {type: :unary, operator:, right:}
      else
        postfix
      end
    end

    def postfix
      expr = primary

      while matches?("!")
        operator = advance
        expr = {type: :unary, operator:, right: expr}
      end

      expr
    end

    def primary
      if matches?("(")
        grouping
      elsif matches?(/\d/)
        number
      elsif keyword?
        keyword
      elsif at_end?
        raise "EOF"
      else
        raise "Expected an expression, got '#{peek}'"
      end
    end

    def grouping
      advance # consume "("
      expr = program # recursively parse a new expression
      expect(")", "Expected a closing parenthesis")
      expr
    end

    def number
      number = advance.to_i

      if matches?(".")
        advance # consume "."
        if matches?(/\d/)
          decimal_digits = advance
          decimal_part = decimal_digits.to_f / (10**decimal_digits.length)

          number += decimal_part
        else
          raise "Invalid number"
        end
      end

      {type: :number, value: number}
    end

    def keyword
      value = KEYWORDS[advance]

      {type: :number, value:}
    end

    private

    def matches?(*types)
      types.any? { it === peek }
    end

    def advance = @tokens.shift

    def expect(type, msg)
      return advance if matches?(type)

      raise msg
    end

    def at_end? = @tokens.empty?

    def peek = @tokens.first

    def keyword? = KEYWORDS[peek]
  end
end
