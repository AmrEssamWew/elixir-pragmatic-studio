defmodule Servy.Kickserver do
  @doc """
  this Genserver starts the httpserver - traps abnormal exists and restarts it acting like a demo supervisor
  """
  use GenServer
  alias Servy.HttpServer

  def start_link(_) do
    GenServer.start_link(__MODULE__,:ok,name: :kick)
  end



  def init(:ok) do
   Process.flag(:trap_exit,true)
   server_id= start_child()
    {:ok,server_id}
  end

def handle_info({:EXIT,pid,reason}, _) do
  IO.puts("child process #{inspect (pid)} was exited due to #{inspect (reason)}")
  server_id= start_child()
  {:noreply,server_id}
end
def start_child() do
  port= Application.get_env(:servy,:port)
  server_id= spawn_link(HttpServer,:start,[port])
  Process.register(server_id,:http)
  server_id
end
end
