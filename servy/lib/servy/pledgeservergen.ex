defmodule Pledges do
  @moduledoc """
  This is a struct to encapslates the GenServer state
  """
  defstruct pledges: [],
            cached_num: 3
end

defmodule Servy.PledgeServerGen do
  @doc """
  This is an example of using GenServer to creates a pledges list , maintain it on it's state and
  return a cached value of it depending on a chached number that is by default 3 but can be set from the client
  """
  use GenServer
  @name :pledges_server
  def start_server, do: GenServer.start(__MODULE__, %Pledges{}, name: @name)

  def init(init_arg) do
    {:ok, init_arg}
  end
  @doc """
  This funcation is to create a pledge record and store it on the pledges list
  """
  def create_pledge(name, amount), do: GenServer.call(@name, {:create, name, amount}) |> IO.puts()
  @doc """
  This funcation is to fetch the cached pledges value depending on the cached number value
  """
  def recent_pledges(), do: GenServer.call(@name, :fetch)
  @doc """
  This funcation is used to set the cached number value
  """
  def update_cached_num(num), do: GenServer.cast(@name, {:update_cached, num})

  def handle_call({:create, name, amount}, _from, state) ,do: {:reply,"Created",%{state | pledges: [{name,amount}| state.pledges ]}}


  def handle_call(:fetch, _from, state) ,do: {:reply,Enum.take(state.pledges,state.cached_num),state}

  def handle_cast({:update_cached, num}, state) ,do: {:noreply,%{ state| cached_num: num }}
end
