#!/usr/local/bin/elixir

{:ok, data} =
  __ENV__.file
  |> Path.dirname()
  |> Path.join("image.gif")
  |> File.read()

<<
  imagetype::binary-size(3),
  version::binary-size(3),
  _rest::binary
>> = data

bin2str = &Enum.join(for <<c::utf8 <- &1>>, do: <<c::utf8>>)

MyTest.test_all(
  __ENV__.file,
  [
    {
      "GIF",
      bin2str.(imagetype),
      "Type"
    },
    {
      "89",
      version
      |> bin2str.()
      |> String.slice(0, 2),
      "Version"
    }
  ]
)
