defmodule Servy.Pledgestorage do
  @doc """
  Using ETS to store the Pledges and fetch them when needed
  """
  use GenServer, restart: :transient
  @storage_table :pledgeslist
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    :ets.new(@storage_table, [:ordered_set, :private, :named_table])
    {:ok, {}}
  end

  def create_pledge(data), do: GenServer.cast(__MODULE__, {:store, data})
  def recent_pledges(), do: GenServer.call(__MODULE__, :fetch)

  def handle_cast({:store, data}, _) do
    :ets.insert(@storage_table, data)
    {:noreply, data}
  end

  def handle_call(:fetch, _, state) do
    {:reply, :ets.tab2list(@storage_table), state}
  end
end
