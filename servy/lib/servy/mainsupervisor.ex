defmodule Servy.MainSupervisor do
  use Supervisor

  def start_link(),do: Supervisor.start_link(__MODULE__,:ok,name: __MODULE__)
  def init(:ok) do
    [Servy.MidSupervisor , Servy.Kickserver]
    |> Supervisor.init(strategy: :one_for_one)
  end
end
