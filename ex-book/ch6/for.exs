#!/usr/local/bin/elixir

testname =
  IO.ANSI.bright() <> IO.ANSI.light_green() <> __ENV__.file <> IO.ANSI.reset()

IO.puts("Testing #{testname}...")

nums = [1, 2, 3]
acml = 0

for n <- nums do
  acml = acml + n
  # Suppressing warning
  _ = acml
end

case acml do
  0 ->
    IO.inspect(:ok)

  res ->
    IO.write("Unexpected: ")
    IO.inspect(res)
end
