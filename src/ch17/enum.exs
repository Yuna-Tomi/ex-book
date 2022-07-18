#!/usr/local/bin/elixir

data = [
  %{name: "alice", grade: :a},
  %{name: "david", grade: :a},
  %{name: "carol", grade: :b},
  %{name: "bob", grade: :b},
  %{name: "eve", grade: :c}
]

MyTest.test_all(
  __ENV__.file,
  [
    {
      ["Alice", "Bob", "Eve"],
      data
      |> Enum.group_by(& &1.grade, & &1.name)
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(&Enum.sort/1)
      |> Enum.map(&Enum.at(&1, 0))
      |> List.flatten()
      |> Enum.map(&String.capitalize/1),
      "Groupby"
    }
  ]
)
