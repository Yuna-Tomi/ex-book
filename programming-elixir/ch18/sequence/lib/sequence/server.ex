defmodule Sequence.Server do
  use GenServer, restart: :transient
  alias Sequence.Impl
  @server __MODULE__

  def start_link(_), do: GenServer.start_link(@server, nil, name: @server)
  def next_number, do: GenServer.call(@server, :next_number)
  def increment_number(delta), do: GenServer.cast(@server, {:increment_number, delta})

  def init(_) do
    {:ok, Sequence.Stash.get()}
  end

  # 返答あり
  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, Impl.next(current_number)}
  end

  # 返答なし
  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, Impl.increment(current_number, delta)}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end
end
