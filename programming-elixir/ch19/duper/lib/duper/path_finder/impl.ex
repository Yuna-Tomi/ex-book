defmodule Duper.PathFinder.Impl do
  def get_next_path(dir_walker) do
    case DirWalker.next(dir_walker) do
      [path] -> path
      other -> other
    end
  end
end
