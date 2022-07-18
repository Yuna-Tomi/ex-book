#!/usr/local/bin/elixir

defmodule Mul do
  def mul(a, b), do: a * b
end

chain = &(&1 |> Mul.mul(&2) |> Mul.mul(&3) |> Mul.mul(&4))

MyTest.test_all(
  __ENV__.file,
  [
    {
      105,
      chain.(1, 3, 5, 7),
      "Chain1"
    },
    {
      384,
      chain.(2, 4, 6, 8),
      "Chain2"
    }
  ]
)
