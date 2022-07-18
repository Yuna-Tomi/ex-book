#!/usr/local/bin/elixir

testname =
  IO.ANSI.bright() <> IO.ANSI.light_green() <> __ENV__.file <> IO.ANSI.reset()

IO.puts("Testing #{testname}...")

defmodule Pipe do
  def mul(x) do
    x * 2
  end

  def mulany(x, y) do
    x * y
  end
end

x =
  1
  |> Pipe.mul()
  |> Pipe.mul()
  |> Pipe.mul()

cond do
  x == 8 -> IO.inspect(:ok)
  true -> IO.inspect(:ng)
end

y =
  1
  |> Pipe.mulany(3)
  |> Pipe.mulany(5)
  |> Pipe.mulany(7)

cond do
  y == 105 -> IO.inspect(:ok)
  true -> IO.inspect(:ng)
end
