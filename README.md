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

- Add support for other math operations like multiplication and division. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/0ac37f16035bd9e41b42c9d2557ea9f08e554e92)
  - Note that they have lower precedence than addition and subtraction:
    - `1 + 2 * 3` should be evaluated as `1 + (2 * 3)`.
  - How would you handle division by zero?
- Add support for parentheses to change the order of operations. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/4316fae53a7ec82f2fbc8f47a2b16c74c7e4ad49)
- Add support for unary expressions like `-1`. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/c4ad8bedc9c4065705bb89fb568bb6de9902c7a4)
  - Note that they have higher precedence than binary expressions:
    - `-1 + 2` should be evaluated as `(-1) + 2`.
- Add support for postfix operators like `5!` (factorial). [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/5f0710ab1704d88304ede801998147e3fd8d137e)
  - Note that they have higher precedence than unary and binary expressions:
    - `-5! + 2` should be evaluated as `-(5!) + 2`.
- Add support for floating point numbers. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/00bf8cc9480471f0ef3ea00806fe674f76349dfb)
  - This will require the parser to be modified to support decimal points.
  - Should all numbers be treated as floating point numbers? What are the trade-offs?
- Add custom keywords like `pi` or `e`. [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/d84c2706bef2c27fb17e09be4c2c393f2d42a067)
- Add a custom syntax like `apply(+ from 1 to 4)` [Possible implementation](https://github.com/MatheusRich/ruby_math_interpreter/commit/125918f272349351206d9dac3473649df36811f1)
  - This should be equivalent to `1 + 2 + 3 + 4`.
  - How would you handle an inverted range like `apply(+ from 4 to 1)`?
  - How would you handle an empty range like `apply(+ from 0 to 0)`?

There are commented out specs at [spec/support/behaves_like_a_math_interpreter.rb][shared-spec] for these features. You can uncomment them and implement the features one by one. Change the tests, if you want different behavior.

[shared-spec]: https://github.com/MatheusRich/ruby_math_interpreter/blob/main/spec/support/behaves_like_a_math_interpreter.rb
