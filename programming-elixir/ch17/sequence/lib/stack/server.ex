defmodule Stack.Server do
  use GenServer

  def start_link(initial_values) when is_list(initial_values) do
    GenServer.start_link(__MODULE__, initial_values, name: __MODULE__)
  end

  def pop() do
    GenServer.call(__MODULE__, :pop)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def init(initial_values) when is_list(initial_values) do
    {:ok, initial_values}
  end

  def handle_call(:pop, _from, current_stack) do
    [pop | remnants] = current_stack
    {:reply, pop, remnants}
  end

  def handle_cast({:push, value}, current_stack) do
    {:noreply, [value | current_stack]}
  end
end
