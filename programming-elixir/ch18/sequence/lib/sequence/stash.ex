defmodule Sequence.Stash do
  use GenServer
  @mod __MODULE__
  def start_link(initial_number) do
    GenServer.start_link(@mod, initial_number, name: @mod)
  end

  def get, do: GenServer.call(@mod, :get)
  def update(new_number), do: GenServer.cast(@mod, {:update, new_number})
  def init(initial_number), do: {:ok, initial_number}
  def handle_call(:get, _from, current_number), do: {:reply, current_number, current_number}
  def handle_cast({:update, new_number}, _current_bumber), do: {:noreply, new_number}
end
