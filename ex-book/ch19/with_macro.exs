#!/usr/local/bin/elixir

data = [
  %{name: "alice", score: "75"},
  %{name: "david", score: "50"},
  %{name: "carol", score: nil},
  %{name: "bob", score: "100"},
  %{name: "eve", score: "?"}
]

MyTest.test_all(
  __ENV__.file,
  [
    {
      ["Bob", "Alice", "David"],
      data
      |> Enum.map(fn user ->
        with %{name: name, score: score} when is_binary(score) <- user,
             {i, ""} <- Integer.parse(score) do
          %{name: name, score: i}
        else
          _ -> nil
        end
      end)
      |> Enum.reject(&is_nil(&1))
      |> Enum.sort_by(& &1.score, :desc)
      |> Enum.map(fn user ->
        String.capitalize(user.name)
      end),
      "WithMacro"
    }
  ]
)
