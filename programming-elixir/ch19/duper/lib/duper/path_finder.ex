defmodule Duper.PathFinder do
  @moduledoc """
  ディレクトリ下の file を走査する。
  """
  @me PathFinder

  @doc """
  次の file path を返す。
  """
  def next_path, do: GenServer.call(@me, :next_path)
end
