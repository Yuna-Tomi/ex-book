#!/usr/local/bin/elixir

file = __ENV__.file
dir = Path.dirname(file)

testname = IO.ANSI.bright() <> IO.ANSI.light_green() <> file <> IO.ANSI.reset()
IO.puts("Testing #{testname}...")

res =
  dir
  |> Path.join("exist.txt")
  |> File.write("Hello, Elixir!!")

case res do
  :ok ->
    IO.inspect(:ok)

  res ->
    IO.write("Unexpected: ")
    IO.inspect(res)
end

res =
  dir
  |> Path.join("not-exist.txt")
  |> File.read()

case res do
  {:error, :enoent} ->
    IO.inspect(:ok)

  res ->
    IO.write("Unexpected: ")
    IO.inspect(res)
end
