#!/usr/local/bin/elixir

IO.puts("-- Logs are like below --")
Logging.info("Info level log.  |")
Logging.warn("Warn level log.  |")
Logging.fatal("Error level log. |")
IO.puts("-------------------------")
IO.puts("")

MyTest.test_all(
  __ENV__.file,
  [
    # Expected to be fail
    {1, 1, "WillPass"},
    {4, rem(14, 5), "WillPass"},

    # Expected to be fail
    {1, 3, "WillFail(expected to be failed)"},
    {:true, 1, "WillFail(expected to be failed)"},

    # Without name
    {1, 1},
  ]
)
