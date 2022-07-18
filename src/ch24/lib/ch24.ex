defmodule Ch24 do
  defp parse_line(line) do
    case Integer.parse(line) do
      {i, ""} -> i
      _ -> 0
    end
  end

  def get_total(list) when is_list(list) do
    list
    |> Enum.map(&parse_line/1)
    |> Enum.sum()
  end

  def get_total(data), do: data |> String.split("\n") |> get_total()
end
