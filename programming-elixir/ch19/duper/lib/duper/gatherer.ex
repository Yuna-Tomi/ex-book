defmodule Duper.Gatherer do
  @me Gatherer
  def done, do: GenServer.cast(@me, :done)
  def result(path, hash), do: GenServer.cast(@me, {:result, path, hash})
end
