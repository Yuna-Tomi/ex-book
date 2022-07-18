#!/usr/local/bin/elixir

defmodule CallSyntax do
  def greet(name, options \\ []) do
    greet = options[:greet] || "Hello"
    exclam = options[:excl] || "!!"
    greet <> ", " <> name <> exclam
  end
end

MyTest.test_all(
  __ENV__.file,
  [
    {"Hello, Foo!!", CallSyntax.greet("Foo"), "HelloFoo!"},
    {"Hello, Foo?", CallSyntax.greet("Foo", excl: "?"), "HelloFoo?"},
    {"こんにちは, Bar！", CallSyntax.greet("Bar", greet: "こんにちは", excl: "！"),
     "Japanese"}
  ]
)
