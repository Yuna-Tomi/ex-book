defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  def schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
        # 先頭のタスクを ready なプロセスに投げる
        send(pid, {:continue, next, self()})
        schedule_processes(processes, tail, results)

      {status, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          case status do
            :ready ->
              # 処理が完全に終了,　昇順でソートして返す
              Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)

            error ->
              raise RuntimeError, message: "Last process encountered an error (#{error})."
          end
        end

      {:done, specifier, res, _pid} ->
        # 計算が終わったものを受け取って results に追加
        schedule_processes(processes, queue, [{specifier, res} | results])
    end
  end
end
