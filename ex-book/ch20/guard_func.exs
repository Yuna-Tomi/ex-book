#!/usr/local/bin/elixir

defmodule Eval do
  def eval(%{name: name} = map) when map.score >= 75, do: "* " <> name
  def eval(%{name: name} = map) when map.score >= 50, do: "+ " <> name
  def eval(%{name: name}), do: "  " <> name
end

defmodule Math do
  def fib(0), do: 1
  def fib(1), do: 1
  def fib(n) when n < 0, do: nil
  def fib(n), do: fib(n - 1) + fib(n - 2)
end

data = [
  %{name: "Alice", score: 100},
  %{name: "Bob", score: 20},
  %{name: "Carol", score: 50},
  %{name: "David", score: 60},
  %{name: "Eve", score: 80}
]

MyTest.test_all(
  __ENV__.file,
  [
    {
      [
        "* Alice",
        "  Bob",
        "+ Carol",
        "+ David",
        "* Eve"
      ],
      Enum.map(
        data,
        &Eval.eval/1
      ),
      "Eval"
    },
    {
      [1, 1, 2, 3, 5, 8, 13, 21, 34, 55],
      for n <- 0..9 do
        Math.fib(n)
      end,
      "Math"
    }
  ]
)
