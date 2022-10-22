defmodule Duper.WorkerSupervisor do
  use DynamicSupervisor
  @me WorkerSupervisor
  def start_link(_), do: DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  # DynamicSupervisor では　:one_for_one のみ有効
  def init(:no_args), do: DynamicSupervisor.init(strategy: :one_for_one)
  def add_worker(), do: {:ok, _pid} = DynamicSupervisor.start_child(@me, Duper.Worker.Server)
end
