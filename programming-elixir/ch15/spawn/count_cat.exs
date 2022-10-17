defmodule CountCat do
  def exec(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:continue, filename, client} ->
        content =
          case File.read(filename) do
            {:ok, bin} ->
              bin

            {:error, :eisdir} ->
              # ディレクトリは無視
              exec(scheduler)

            {:error, posix} ->
              send(client, {posix, self()})
              exit(:kill)
          end

        count = content |> String.split("cat") |> length()
        send(client, {:done, filename, count - 1, self()})

        exec(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end
end

# fib(40) を 20 回計算させるタスクの実行時間を process 1~10 個で比較m
dirpath =
  case System.argv() do
    [arg | _] ->
      arg

    [] ->
      IO.puts("Need directory path to inspect.")
      System.halt(1)
  end

filenames =
  case File.ls(dirpath) do
    {:ok, filenames} ->
      Enum.map(filenames, fn name -> Path.join(dirpath, name) end)

    {:error, posix} ->
      IO.puts(posix)
      System.halt(1)
  end

Enum.each(1..10, fn num_processes ->
  {time, res} =
    :timer.tc(
      Scheduler,
      :run,
      [num_processes, CountCat, :exec, filenames]
    )

  if num_processes == 1 do
    res |> inspect |> IO.puts()
    IO.puts("\n #    time (s)")
  end

  :io.format("~2B  ~.2f~n", [num_processes, time / 1_000_000.0])
end)
