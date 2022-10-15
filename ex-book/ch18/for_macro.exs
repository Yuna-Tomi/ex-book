#!/usr/local/bin/elixir

data = [
  %{name: "alice", grade: :a},
  %{name: "david", grade: :a},
  %{name: "carol", grade: :b},
  %{name: "bob", grade: :b},
  %{name: "eve", grade: :c}
]

bitstring = <<0b00_101::5, 0b11_011::5, 0b10_010::5, 0b00_100::5, 0b000::3>>

MyTest.test_all(
  __ENV__.file,
  [
    {
      ["Alice", "David"],
      for(d <- data, d.grade == :a, do: String.capitalize(d.name)),
      "ForMacro"
    },
    {
      ["Differ", "Same", "Same", "Differ"],
      for(<<a::2, b::3 <- bitstring>>,
        do: if(a == b, do: "Same", else: "Differ")
      ),
      "BitStringGen"
    }
  ]
)
