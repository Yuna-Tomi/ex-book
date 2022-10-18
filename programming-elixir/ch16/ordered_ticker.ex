# Practice: Node-3
defmodule Ticker do
  @interval 2000
  @name :ticker
  def start do
    # サーバは最初に自身の名前を登録する(これでクライアントが参照できるようになる)
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(cliend_pid) do
    send(:global.whereis_name(@name), {:register, cliend_pid})
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        generator([pid | clients])
    after
      @interval ->
        IO.puts("tick")

        # 毎回の通知では登録された順に 1 クライアントずつ通知
        # (1 巡するのに @interval * num_client かかる)
        case clients do
          [to_send | others] ->
            send(to_send, {:tick})
            reversed = Enum.reverse(others)
            rotated = Enum.reverse([to_send | reversed])
            generator(rotated)

          _ ->
            generator([])
        end
    end
  end
end
