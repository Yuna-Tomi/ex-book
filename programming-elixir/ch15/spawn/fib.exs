defmodule Fib do
  def exec(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:continue, n, client} ->
        send(client, {:done, n, calc(n), self()})
        # 次のリクエスト受付のために再帰呼び出しが必要
        exec(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp calc(n) when n <= 0, do: 0
  defp calc(1), do: 1

  # 主題が並行処理のパフォーマンスなのでわざとメモ化などをしない実装を使う
  defp calc(n) do
    calc(n - 1) + calc(n - 2)
  end
end

# fib(40) を 20 回計算させるタスクの実行時間を process 1~10 個で比較
to_process = List.duplicate(40, 20)

Enum.each(1..10, fn num_processes ->
  {time, res} =
    :timer.tc(
      Scheduler,
      :run,
      [num_processes, Fib, :exec, to_process]
    )

  if num_processes == 1 do
    res |> inspect |> IO.puts()
    IO.puts("\n #    time (s)")
  end

  :io.format("~2B  ~.2f~n", [num_processes, time / 1_000_000.0])
end)
