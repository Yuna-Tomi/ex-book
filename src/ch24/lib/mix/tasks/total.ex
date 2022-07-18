defmodule Mix.Tasks.Total do
  @shortdoc "Display the total"
  use Mix.Task

  def run([]), do: read_data_and_get_total("data.txt")
  def run([path]), do: read_data_and_get_total(path)
  def run(_args), do: IO.puts("Usage: mix total [path]")

  defp read_data_and_get_total(path) do
    case File.read(path) do
      {:ok, data} ->
        data
        |> Ch24.get_total()
        |> IO.puts()

      {:error, _} ->
        IO.puts("Failed to read file `#{path}`.")
    end
  end
end
