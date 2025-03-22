RSpec.shared_examples "a math interpreter" do
  describe "operators" do
    it "evaluates addition" do
      expect(subject.call("1 + 1")).to eq(2)
    end

    it "evaluates subtraction" do
      expect(subject.call("1 - 2")).to eq(-1)
    end

    # it "evaluates multiplication" do
    #   expect(subject.call("2 * 3")).to eq(6)
    # end

    # it "evaluates division" do
    #   expect(subject.call("8 / 3")).to eq(2) #  # Integer division
    # end

    # it "respects operator precedence" do
    #   expect(subject.call("1 + 2 * 3 - 4 / 2")).to eq(5)
    # end
  end

  # describe "grouping" do
  #   it "evaluates grouped expressions first" do
  #     expect(subject.call("(1 + 2) * 3")).to eq(9)
  #   end

  #   context "when parentheses are not closed" do
  #     it "raises an error" do
  #       expect { subject.call("(1 + 2") }.to raise_error(/Expected a closing parenthesis/)
  #     end
  #   end
  # end

  # describe "unary expressions" do
  #   it "evaluates unary expressions" do
  #     expect(subject.call("-1")).to eq(-1)
  #   end

  #   it "allows composing unary expressions" do
  #     expect(subject.call("--2")).to eq(2)
  #   end
  # end

  # describe "postfix expressions" do
  #   it "evaluates postfix expressions" do
  #     expect(subject.call("5!")).to eq(120)
  #     expect(subject.call("(5)!")).to eq(120)
  #   end

  #   it "allows composing postfix expressions" do
  #     expect(subject.call("3!!")).to eq(720)
  #   end

  #   it "handles precedence correctly" do
  #     expect(subject.call("2 + -3!")).to eq(-4)
  #   end
  # end

  # describe "floating point numbers" do
  #   it "evaluates floating point numbers" do
  #     expect(subject.call("1.5")).to eq(1.5)
  #     expect(subject.call("2.5 + 3.5")).to eq(6.0)
  #     expect(subject.call("5 / 2.0")).to eq(2.5)
  #   end

  #   context "when the input contains a decimal point without digits" do
  #     it "raises an error" do
  #       expect { subject.call("1.") }.to raise_error(/Invalid number/)
  #     end
  #   end
  # end

  # describe "constants" do
  #   it "evaluates constants" do
  #     expect(subject.call("pi")).to eq(Math::PI)
  #     expect(subject.call("e")).to eq(Math::E)
  #   end
  # end

  # describe "application" do
  #   it "reduces the range using the given operator" do
  #     expect(subject.call("apply(+ from 1 to 4)")).to eq(10)
  #     expect(subject.call("apply(* from 1 to 5)")).to eq(120)
  #     expect(subject.call("apply(- from 5 to 1)")).to eq(-5)
  #     expect(subject.call("apply(/ from 3 to 1)")).to eq(1)
  #   end

  #   context "when the range is inverted" do
  #     it "handles it correctly" do
  #       expect(subject.call("apply(+ from 4 to 1)")).to eq(10)
  #       expect(subject.call("apply(- from 1 to 5)")).to eq(-13)
  #       expect(subject.call("apply(* from 5 to 1)")).to eq(120)
  #       expect(subject.call("apply(/ from 3 to 2)")).to eq(1)
  #     end
  #   end

  #   context "when the range is empty" do
  #     it "returns the initial value" do
  #       expect(subject.call("apply(+ from 1 to 1)")).to eq(1)
  #       expect(subject.call("apply(* from 2 to 2)")).to eq(2)
  #       expect(subject.call("apply(- from 3 to 3)")).to eq(3)
  #       expect(subject.call("apply(/ from 4 to 4)")).to eq(4)
  #     end
  #   end

  #   context "when the range includes a floating point number" do
  #     it "raises an error" do
  #       expect { subject.call("apply(+ from 1.0 to 3)") }.to raise_error(/Invalid range/)
  #       expect { subject.call("apply(+ from 1 to 3.0)") }.to raise_error(/Invalid range/)
  #       expect { subject.call("apply(+ from (1 + 0.1) to 3)") }.to raise_error(/Invalid range/)
  #     end
  #   end

  #   context "when the syntax is incorrect" do
  #     it "raises an error" do
  #       expect { subject.call("apply + from 1 to 4") }.to raise_error(/Expected a '\(' after 'apply'/)
  #       expect { subject.call("apply(a from 1 to 4)") }.to raise_error(/Invalid operator 'a'/)
  #       expect { subject.call("apply(+ asdf 1 to 4)") }.to raise_error(/Expected 'from' after operator/)
  #       expect { subject.call("apply(+ from to 4)") }.to raise_error(/Expected an expression, got 'to'/)
  #       expect { subject.call("apply(+ from 1 to)") }.to raise_error(/Expected an expression, got '\)'/)
  #       expect { subject.call("apply(+ from 1 to 4") }.to raise_error(/Expected a '\)' to close the application/)
  #     end
  #   end
  # end

  describe "errors" do
    context "when the input ends unexpectedly" do
      it "raises an error" do
        expect { subject.call("1 +") }.to raise_error(/EOF/)
      end
    end

    context "when an unexpected token is encountered" do
      it "raises an error" do
        expect { subject.call("1 + a") }.to raise_error(/Expected an expression, got 'a'/)
      end
    end
  end
end
