#!/usr/local/bin/elixir

defmodule Empty do
end

x = [
  :atom1,
  [0, "a", "b", 'c'],
  10,
  Empty,
  ["f", ["e", 6, ['fg']]],
  ~w(h i j)
]

MyTest.test_all(
  __ENV__.file,
  [
    {
      true,
      x
      |> List.flatten()
      |> Enum.at(6)
      # module `Empty`
      |> is_atom(),
      "List1"
    },
    {
      ["f", "e", 6, 102, 103],
      x
      |> List.insert_at(0, :atom2)
      |> List.insert_at(-1, "g")
      |> Enum.reverse()
      |> List.delete_at(0)
      |> Enum.at(1)
      |> List.flatten(),
      "List2"
    }
  ]
)
