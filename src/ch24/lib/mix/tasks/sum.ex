defmodule Mix.Tasks.Sum do
  @shortdoc "Sum up the given numbers"
  use Mix.Task

  def run([]), do: IO.puts("Usage: mix sum [numbers]")
  def run(args) when length(args) > 0, do: args |> Ch24.get_total() |> IO.puts()
  def run(_args), do: IO.puts("Usage: mix sum [numbers]")
end
