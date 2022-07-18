#!/usr/local/bin/elixir

defmodule DoElseExpansion do
  def func(a, b_c \\ []) do
    b = b_c[:do] || 1
    c = b_c[:else] || 2
    a * b + c
  end

  def odd_even(num), do: if(Integer.mod(num, 2) == 0, do: :even, else: :odd)
end

MyTest.test_all(
  __ENV__.file,
  [
    {
      25,
      DoElseExpansion.func(2, do: 10, else: 5),
      "NormalCallSyntax"
    },
    {
      25,
      DoElseExpansion.func 2 do
        10
      else
        5
      end,
      "DoElseExpansion"
    },
    {
      :even,
      DoElseExpansion.odd_even(100),
      "Even"
    },
    {
      :odd,
      DoElseExpansion.odd_even(101),
      "Even"
    }
  ]
)
