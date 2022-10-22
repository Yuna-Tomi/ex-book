defmodule Duper.Worker.Server do
  use GenServer, restart: :transient
  alias Duper.Worker.Impl
  def start_link(_), do: GenServer.start_link(__MODULE__, :no_args)

  def init(:no_args) do
    Process.send_after(self(), :do_one_file, 0)
    {:ok, nil}
  end

  def handle_info(:do_one_file, _) do
    Duper.PathFinder.next_path()
    |> add_result()
  end

  defp add_result(nil) do
    Duper.Gatherer.done()
    {:stop, :normal, nil}
  end

  defp add_result(path) do
    Duper.Gatherer.result(path, Impl.hash_of_file_at(path))
    send(self(), :do_one_file)
    {:noreply, nil}
  end
end
