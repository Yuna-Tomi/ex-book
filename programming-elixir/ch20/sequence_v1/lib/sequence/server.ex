defmodule Sequence.Server do
  use GenServer, restart: :transient
  require Logger
  @server __MODULE__
  @vsn "1"

  defmodule State do
    defstruct(current_number: 0, delta: 1)
  end

  def start_link(_), do: GenServer.start_link(@server, nil, name: @server)

  def next_number do
    with number = GenServer.call(@server, :next_number),
      do: "The next number is #{number}"
  end

  def increment_number(delta), do: GenServer.cast(@server, {:increment_number, delta})

  def init(_) do
    state = %State{current_number: Sequence.Stash.get()}
    {:ok, state}
  end

  # 返答あり
  def handle_call(:next_number, _from, state = %{current_number: n}) do
    {:reply, n, %{state | current_number: n + state.delta}}
  end

  # 返答なし
  def handle_cast({:increment_number, delta}, state) do
    {:noreply, %{state | delta: delta}}
  end

  def terminate(_reason, current_number) do
    Sequence.Stash.update(current_number)
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect(state)}', and I'm happy"}]]
  end

  def code_change("0", old_state = current_number, _extra) do
    new_state = %State{
      current_number: current_number,
      delta: 1
    }

    Logger.info("Changing code from 0 to 1")
    Logger.info(inspect(old_state))
    Logger.info(inspect(new_state))
    {:ok, new_state}
  end
end
