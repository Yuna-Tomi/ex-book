#!/usr/local/bin/elixir

defmodule StringBuffer do
  use Agent

  def start_link() do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def append(name, str) do
    Agent.update(__MODULE__, fn state ->
      cur = Map.get(state, name, "")
      Map.put(state, name, cur <> str)
    end)
  end

  def get_value(name) do
    Agent.get(__MODULE__, &Map.get(&1, name, ""))
  end

  def reset(name) do
    Agent.update(__MODULE__, fn state ->
      Map.delete(state, name)
    end)
  end
end

StringBuffer.start_link()
StringBuffer.append(:a, "A")
StringBuffer.append(:b, "B")
StringBuffer.append(:a, "C")
StringBuffer.append(:c, "D")
StringBuffer.reset(:b)

MyTest.test_all(
  __ENV__.file,
  [
    {
      "AC",
      StringBuffer.get_value(:a),
      "StringBuffer2A"
    },
    {
      "",
      StringBuffer.get_value(:b),
      "StringBuffer2B"
    },
    {
      "D",
      StringBuffer.get_value(:c),
      "StringBuffer2C"
    }
  ]
)
