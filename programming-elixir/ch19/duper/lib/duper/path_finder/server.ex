defmodule Duper.PathFinder.Server do
  use GenServer
  alias Duper.PathFinder.Impl
  @me PathFinder

  def start_link(root), do: GenServer.start_link(__MODULE__, root, name: @me)
  def init(dir_path), do: DirWalker.start_link(dir_path)

  def handle_call(:next_path, _from, dir_walker),
    do: {:reply, Impl.get_next_path(dir_walker), dir_walker}
end
