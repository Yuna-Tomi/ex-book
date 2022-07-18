#!/usr/local/bin/elixir

defmodule Console do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(state) do
    Process.send(__MODULE__, :process_command, [])
    {:ok, state}
  end

  def handle_info(:process_command, state) do
    command =
      "<COMMAND> "
      |> IO.gets()
      |> String.trim()

    case command do
      "rand" <> arg -> exec_rand(arg)
      "echo" <> args -> exec_echo(args)
      "sum" <> args -> exec_sum(args)
      "exit" -> System.halt(0)
      _ -> IO.puts("UNKNOWN COMMAND")
    end

    Process.send(__MODULE__, :process_command, [])
    {:noreply, state}
  end

  defp exec_rand(arg) do
    case arg |> String.trim() |> Integer.parse() do
      {n, ""} -> IO.puts(:rand.uniform(n))
      _ -> IO.puts("ERROR")
    end
  end

  defp exec_echo(args) do
    args
    |> String.trim_leading()
    |> String.split()
    |> Enum.join(" ")
    |> IO.puts()
  end

  defp exec_sum(args) do
    args
    |> String.trim()
    |> String.split()
    |> Enum.reduce(0, fn elem, acc ->
      case Integer.parse(elem) do
        {n, ""} -> acc + n
        _ -> acc
      end
    end)
    |> IO.puts()
  end
end

# テストで実行されないようコメントアウト
Console.start_link(nil)
