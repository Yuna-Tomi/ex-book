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

        Enum.each(clients, fn client ->
          send(client, {:tick})
        end)

        generator(clients)
    end
  end
end
