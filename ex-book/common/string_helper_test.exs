#!/usr/local/bin/elixir

MyTest.test_all(
  __ENV__.file,
  [
    {"0b0000_0011", StringHelper.to_bits(<<3::8>>), "BitString3"},
    {"0b01_0100", StringHelper.to_bits(<<20::6>>), "BitString20"},
    {"0x 00 03", StringHelper.to_hex(<<3::16>>), "Hex3"},
    {"0x 00 24 8F", StringHelper.to_hex(<<9359::24>>), "Hex9359"},
  ]
)
