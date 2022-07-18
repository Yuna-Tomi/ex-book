#!/usr/local/bin/elixir

testname =
  IO.ANSI.bright() <> IO.ANSI.light_green() <> __ENV__.file <> IO.ANSI.reset()

IO.puts("Testing #{testname}...")

defmodule MyModule do
  def double(a) when is_number(a), do: a * 2
  def double(_), do: raise(ArgumentError)
  def raise_on_non_atom(a) when is_atom(a), do: :ok
  def raise_on_non_atom(_), do: raise(ArgumentError)
end

ExUnit.start(exclude: :not_implemented)

defmodule TestMyModule do
  use ExUnit.Case

  describe "double" do
    test "must be ok" do
      assert MyModule.double(999) == 1998
    end

    test "must raise" do
      assert_raise ArgumentError, fn ->
        MyModule.double(:atom)
      end
    end
  end

  describe "raise_on_non_atom" do
    test "must be ok" do
      assert MyModule.raise_on_non_atom(:atom) == :ok
    end

    test "must raise" do
      assert_raise ArgumentError, fn ->
        MyModule.raise_on_non_atom(10)
      end
    end
  end

  # unimplemented test but ignored
  test "will be implemented in future"
end
