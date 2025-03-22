# Ruby Math Interpreter

This repo contains two simple math interpreters written in Ruby built in the
[Ruby Internals: A Guide For Rails Developers][] talk.

[Ruby Internals: A Guide For Rails Developers]: https://www.tropicalonrails.com/matheus-richard

The interpreters can evaluate mathematical expressions and support basic
operations like addition and subtraction.

The `tree_walker.rb` file contains a tree-walking interpreter that can evaluate
mathematical expressions represented as an abstract syntax tree (AST).

The `bytecode.rb` file contains a bytecode interpreter that can execute
mathematical expressions compiled into bytecode. The bytecode is loosely
inspired by Ruby's YARV.

## Installation

- Clone the repository:

```bash
git clone https://github.com/matheusrich/ruby-math-interpreter.git
```

- Change into the directory:

```bash
cd ruby-math-interpreter
```

- Install the dependencies:

```bash
bundle install
```

- Run the tests:

```bash
bundle exec rspec
```

To run the tree-walking interpreter, use the following command:

```bash
bin/tree-walker "1 + 2 - 3"
```

To run the bytecode interpreter, use the following command:

```bash
bin/bytecode-vm "1 + 2 - 3"
```

## Exercises for the reader

There's a number of things you can try adding to the language to make it more
fun. Ensure you add tests for each of these features. There's a RSpec [shared
example][shared-spec] you can modify to add tests for both interpreters at the same time.

Here's a list of possible new features, but feel free to come up with your own
ideas.

> [!TIP]
> There's also [a branch](https://github.com/matheusrich/ruby-math-interpreter/tree/new-features) with these features implemented for you to use as a reference. Each feature is a separate commit, so you can check them out one by one to see how they were implemented.

- Add support for other math operations like multiplication and division. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/60539a69b1ba24b7c560f7e67acb62c5db88dfef)
  - Note that they have lower precedence than addition and subtraction:
    - `1 + 2 * 3` should be evaluated as `1 + (2 * 3)`.
  - How would you handle division by zero?
- Add support for parentheses to change the order of operations. [Possible
  implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/96eed28fac32d8e1cd98b9b67056eeccb1ceb872)
- Add support for unary expressions like `-1`. [Possible
  implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/8b7f6181ed5f0bc6661f3380bfc94e9e691046b4)
  - Note that they have higher precedence than binary expressions:
    - `-1 + 2` should be evaluated as `(-1) + 2`.
- Add support for postfix operators like `5!` (factorial). [Possible
  implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/69707ca93a7f315a257207bb35ac68730794e948)
  - Note that they have higher precedence than unary and binary expressions:
    - `-5! + 2` should be evaluated as `-(5!) + 2`.
- Add support for floating point numbers. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/e328e0ce330c83e0af7ba4593c49f7e422fc1655)
  - This will require the parser to be modified to support decimal points.
  - Should all numbers be treated as floating point numbers? What are the trade-offs?
- Add custom keywords like `pi` or `e`. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/c14108692ff996c502ff8768d4f2af0401948d96)
- Add a custom syntax like `apply(+ from 1 to 4)` [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/5a181d6c977b80a44fbfb8ff00bb8bef1d02af93)
  - This should be equivalent to `1 + 2 + 3 + 4`.
  - How would you handle an inverted range like `apply(+ from 4 to 1)`?
  - How would you handle an empty range like `apply(+ from 0 to 0)`?

There are commented out specs at [spec/support/behaves_like_a_math_interpreter.rb][shared-spec] for these features. You can uncomment them and implement the features one by one. Change the tests, if you want different behavior.

[shared-spec]: https://github.com/MatheusRich/ruby_math_interpreter/blob/main/spec/support/behaves_like_a_math_interpreter.rb
