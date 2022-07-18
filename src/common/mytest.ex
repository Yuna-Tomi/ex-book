defmodule ColorUtil do
  def cyan(str), do: IO.ANSI.cyan() <> str <> IO.ANSI.reset()
  def yellow(str), do: IO.ANSI.yellow() <> str <> IO.ANSI.reset()
  def red(str), do: IO.ANSI.red() <> str <> IO.ANSI.reset()
end

defmodule Logging do
  defp level2str(:info), do: ColorUtil.cyan("INFO")
  defp level2str(:warn), do: ColorUtil.yellow("WARN")
  defp level2str(:fata), do: ColorUtil.red("FATA")
  defp get_prefix(level), do: "[" <> level2str(level) <> "] "
  defp log(level, msg), do: level |> get_prefix() |> String.replace_suffix("", msg) |> IO.puts()
  def info(msg), do: log(:info, msg)
  def warn(msg), do: log(:warn, msg)
  def fatal(msg), do: log(:fata, msg)
end

defmodule MyTest do
  def assert_inner(expect, result, meta) do
    cond do
      expect === result ->  Logging.info("#{meta} passed.")
      true -> Logging.fatal("#{meta} failed.")
        IO.write(" - " <> ColorUtil.cyan("Expected") <> ": ")
        IO.inspect(expect)
        IO.write(" - " <> ColorUtil.red("Result") <> ": ")
        IO.inspect(result)
    end
  end
  def assert(expect, result), do: assert_inner(expect, result, "Test")
  def assert(expect, result, meta), do: assert_inner(expect, result, "`" <> meta <> "`")


  @moduledoc """
  簡易テスト用の関数
  testees は
  - {expected result, test result}
  - {expected result, test result, meta names}
  のどちらかの Tuple でなくてはならない。
  (meta names) があれば `\#{meta names} passed/failed.` のような形で結果が出力され、
  ない場合には `Test passed/failed.` という出力のみになる。
  """
  def test_all(testname, testees) do
    testname = IO.ANSI.bright() <> IO.ANSI.light_green() <> testname <> IO.ANSI.reset()
    IO.puts("Testing #{testname}...")
    for settings <- testees do
      case settings do
        {expect, result, meta} ->
          assert(expect, result, meta)
        {expect, result} -> assert(expect, result)
        invalid -> Logging.fatal("Invalid settings '#{invalid}' passed. Must be in form of {expected, result} or {expected, result, testname}")
      end
    end
  end
end
