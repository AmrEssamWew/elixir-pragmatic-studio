defmodule Servy do
  use Application
  def start(_start_type, _start_args) do
    IO.puts("Starting the servers")
    Servy.MainSupervisor.start_link()
  end
end
