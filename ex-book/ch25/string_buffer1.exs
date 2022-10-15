#!/usr/local/bin/elixir

defmodule StringBuffer do
  use Agent

  def start_link(initial_state) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def append(str) do
    Agent.update(__MODULE__, &(&1 <> str))
  end

  def get_value do
    Agent.get(__MODULE__, & &1)
  end

  def get_length do
    str = Agent.get(__MODULE__, & &1)
    String.length(str)
  end
end

StringBuffer.start_link("")
StringBuffer.append("A")
StringBuffer.append("B")
StringBuffer.append("C")

MyTest.test_all(
  __ENV__.file,
  [
    {
      "ABC",
      StringBuffer.get_value(),
      "StringBuffer1GetValue"
    },
    {
      3,
      StringBuffer.get_length(),
      "StringBuffer1GetLength"
    }
  ]
)
