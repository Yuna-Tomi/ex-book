defmodule Sequence do
  @server Sequence.Server
  @moduledoc """
  カウンタを提供するサーバ。
  """

  @doc """
  初期値 initial_number からカウント開始

  ## Examples
      iex> Sequence.start_link(10)
      :ok, #PID<...>
  """
  def start_link(initial_number), do: GenServer.start_link(@server, initial_number, name: @server)

  @doc """
  1 カウントする。戻り値は現在の値。
  """
  def next_number, do: GenServer.call(@server, :next_number)

  @doc """
  delta だけカウントする。戻り値なし。(:ok)
  """
  def increment_number(delta), do: GenServer.cast(@server, {:increment_number, delta})
end
