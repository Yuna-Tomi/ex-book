defmodule Duper.Results.Server do
  use GenServer
  alias Duper.Results.Impl
  @me Results

  def start_link(_), do: GenServer.start_link(__MODULE__, :no_args, name: @me)
  def init(:no_args), do: {:ok, %{}}

  def handle_cast({:add, path, hash}, results) do
    results =
      Map.update(
        results,
        hash,
        [path],
        fn existing -> [path | existing] end
      )

    {:noreply, results}
  end

  def handle_call(:find_duplicates, _from, results) do
    {:reply, Impl.hashes_with_more_than_one_path(results), results}
  end
end
