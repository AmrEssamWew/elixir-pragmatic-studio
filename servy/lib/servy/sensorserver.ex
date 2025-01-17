defmodule Servy.SensorServer do
  @moduledoc """
  This module is a practical example of using genserver to doing a periodic tasks.
  it represent a sensor server that updates the sensor reading every 7 seconds
  """
  use GenServer
  alias Servy.VideoCam
  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  def init(_init_arg) do

    {:ok, get_sensors_data()}
  end

  def handle_info(:update, _state) do
    new_state=get_sensors_data()
    IO.inspect(new_state)
    {:noreply,new_state}
  end

  defp get_sensors_data do
    #a funcation simulates fetching the data from the sensors

    Process.send_after(self(),:update,:timer.seconds(7))
    ["cam-1", "cam-2", "cam-3"]
    |> Enum.map(&Task.async(fn -> VideoCam.get_snapshot(&1) end))
    |> Enum.map(&Task.await(&1))
  end
end
