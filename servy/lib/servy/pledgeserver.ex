defmodule Servy.PledgeServer do
  @name :pledge_server
  def start_server() do
    spawn(__MODULE__, :listen_loop, [])
    |> Process.register(@name)
  end

  def create_pledge(name, amount) do
    send(@name, {:create, self(), name, amount})

    receive do
      :created -> IO.puts("Created the new pledge")
      _ -> IO.puts("unexpected error")
    end
  end

  def recent_pledges do
    IO.puts("in the recent_pledges")
    send(@name, {:recent_pledges, self()})

    receive do
      {:fetched, value} ->
        value |> Enum.take(3)

      _ ->
        "Error while fetching the most recent data"
        # code
    end
  end

  # Server
  def listen_loop(current_state \\ []) do


  receive do
    {:create, pid, name, value} ->
      send(pid, :created)
      listen_loop([{name, value} | current_state ])

      {:recent_pledges, pid}->
        send(pid,{:fetched, current_state})
        listen_loop(current_state)

  end
end


  # def listen_loop(current_state \\ []) do
  #   receive do
  #     {:create, pid, name, value} ->
  #       send(pid, :created)
  #       listen_loop([{name, value} | current_state])

  #     _ ->
  #       listen_loop(current_state)
  #   end
  # end


end
