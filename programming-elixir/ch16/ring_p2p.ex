# Practice: Node-4
defmodule P2pClient do
  @interval 2000
  # 1h
  @first_interval 3_600_000
  @name :ticker
  def start do
    # サーバは最初に自身の名前を登録する(これでクライアントが参照できるようになる)
    pid =
      case :global.whereis_name(@name) do
        pid when is_pid(pid) ->
          spawn(__MODULE__, :wait, [@first_interval])

        :undefined ->
          IO.puts("spawning...")
          pid = spawn(__MODULE__, :transfer, [[]])
          :global.register_name(@name, pid)
          pid
      end

    P2pClient.register(pid)
  end

  def register(pid) do
    send(:global.whereis_name(@name), {:register, pid})
  end

  # Transfer しているノードがマスター、みたいな構成になってしまう
  def transfer(clients) do
    # 生きているもののみ残さなければ存在しないクライアントに send して止まる
    clients = filter_alive(clients)

    receive do
      {:register, pid} ->
        IO.puts("#{IO.ANSI.cyan()}#{inspect(pid)}#{IO.ANSI.reset()}registered!!")

        transfer([pid | clients])
    after
      @interval ->
        IO.puts("tick")

        # 念の為 receive 前後で確認 (これも任意のタイミングでの切断に対応できる訳ではなく、十分ではない)
        clients = filter_alive(clients)

        case clients do
          [to_send | others] when is_pid(to_send) ->
            reversed = Enum.reverse(others)
            rotated = Enum.reverse([to_send | reversed])
            :global.re_register_name(@name, to_send)
            send(to_send, {:tick, rotated})
            wait(length(clients) * @interval * 2)

          [] ->
            raise RuntimeError,
              message: "Client lives while clients list is empty."
        end
    end
  end

  def wait(acceptable_delay) do
    IO.puts(acceptable_delay)

    receive do
      {:tick, clients} ->
        transfer(clients)
    after
      acceptable_delay ->
        raise RuntimeError, message: "Too long wait"
    end
  end

  def filter_alive(clients) do
    self_pid = self()

    Enum.drop_while(
      clients,
      fn pid ->
        if not Node.connect(node(pid)) do
          true
        else
          Node.spawn(
            node(pid),
            fn ->
              send(self_pid, {:alive_or_not, Process.alive?(pid)})
            end
          )

          receive do
            {:alive_or_not, alive} -> not alive
          end
        end
      end
    )
  end
end
