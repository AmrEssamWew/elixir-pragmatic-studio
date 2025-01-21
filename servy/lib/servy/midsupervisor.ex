defmodule Servy.MidSupervisor do
  @doc """
  This is a Supervisor that supervises Sensor and Pledge servers and also is been supervised by the main supervisor
  """
  use Supervisor

  def start_link(_), do: Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)

  def init(:ok) do
    [Servy.SensorServer, Servy.Pledgestorage]
   |> Supervisor.init(strategy: :one_for_one)
  end
end
