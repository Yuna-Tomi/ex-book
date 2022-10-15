#!/usr/local/bin/elixir

defmodule OwnEnum do
  def map(enumerable, func) do
    enumerable
    |> Enum.reduce([], fn entry, acc -> [func.(entry) | acc] end)
    # reduce で func の結果を先頭に追加していてそのままだと順序が逆
    |> Enum.reverse()
  end

  def freq(enumerable) do
    Enum.reduce(enumerable, %{}, fn key, acc ->
      case acc do
        %{^key => value} -> Map.put(acc, key, value + 1)
        %{} -> Map.put(acc, key, 1)
      end
    end)
  end
end

MyTest.test_all(
  __ENV__.file,
  [
    {
      %{fizz: 13, buzz: 7, fizz_buzz: 3},
      1..100
      |> Enum.reduce_while(%{fizz: 0, buzz: 0, fizz_buzz: 0}, fn n, acc ->
        cond do
          n > 50 -> {:halt, acc}
          rem(n, 15) == 0 -> {:cont, %{acc | fizz_buzz: acc.fizz_buzz + 1}}
          rem(n, 5) == 0 -> {:cont, %{acc | buzz: acc.buzz + 1}}
          rem(n, 3) == 0 -> {:cont, %{acc | fizz: acc.fizz + 1}}
          true -> {:cont, acc}
        end
      end),
      "FizzBuzz"
    },
    {
      ["7", "9", "11", "13", "15"],
      1..5
      |> OwnEnum.map(&(&1 * 2 + 5))
      |> OwnEnum.map(&Integer.to_string/1),
      "OwnEnumMap"
    },
    {
      %{"0" => 2, "1" => 3, nil => 3, true => 1},
      OwnEnum.freq(["0", nil, nil, true, "1", "0", "1", nil, "1"]),
      "OwnEnumFreq"
    }
  ]
)
