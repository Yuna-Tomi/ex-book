#!/usr/local/bin/elixir

defmodule DoExpansion do
  def func(a, b \\ []) do
    b = b[:do] || 1
    a * b
  end
end

MyTest.test_all(
  __ENV__.file,
  [
    {
      20,
      DoExpansion.func(2, do: 10),
      "NormalCallSyntax"
    },
    {
      20,
      DoExpansion.func 2 do
        10
      end,
      "DoExpansion"
    }
  ]
)
