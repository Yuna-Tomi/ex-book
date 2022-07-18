defmodule StringHelper do
  defp insert(str, count, sep \\ " ") do
    str
      |> String.codepoints()
      |> Enum.reverse()
      |> Enum.chunk_every(count)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.map(&Enum.join/1)
      |> Enum.reverse()
      |> Enum.join(sep)
  end

  def to_bits(bitstring) do
    bs = bit_size(bitstring)
    <<number::size(bs)>> = bitstring
    bin = number
      |> Integer.to_string(2)
      |> String.pad_leading(bs, "0")
      |> insert(4, "_")
    "0b" <> bin
  end

  def to_hex(binary) do
    s = byte_size(binary)
    bs = s * 8
    <<number::size(bs)>> = binary
    hex = number
      |> Integer.to_string(16)
      |> String.pad_leading(s*2, "0")
      |> insert(2)
    "0x " <> hex
  end
end
