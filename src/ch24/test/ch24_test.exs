defmodule Ch24Test do
  use ExUnit.Case

  describe "get_total/1" do
    @data """
    30
    40
    ABC
    15
    """
    test "ignoring non-integers" do
      assert Ch24.get_total(@data) == 85
    end

    test "return 0 for empty string" do
      assert Ch24.get_total("") == 0
    end

    test "can interpret list of strings" do
      assert Ch24.get_total(["15", "25", "50"]) == 90
    end

    test "can interpret list of strings, ignoring non-integers" do
      assert Ch24.get_total(["15", "ABC", "50"]) == 65
    end
  end
end
