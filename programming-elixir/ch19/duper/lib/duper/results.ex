defmodule Duper.Results do
  @me Results
  def add_hash_for(path, hash), do: GenServer.cast(@me, {:add, path, hash})
  def find_duplicates, do: GenServer.call(@me, :find_duplicates)
end
