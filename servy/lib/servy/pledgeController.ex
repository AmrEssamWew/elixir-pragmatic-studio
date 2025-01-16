defmodule Servy.PledgeController do
alias Servy.PledgeServerGen
  def create(conv, %{"name" => name, "amount" => amount}) do
    # Sends the pledge to the external service and caches it
    PledgeServerGen.create_pledge(name, String.to_integer(amount))
    %{ conv | code_status: 201, resp_body: "#{name} pledged #{amount}!" }

  end

  def index(conv) do
    # Gets the recent pledges from the cache
    IO.puts("in the index")
    pledges = PledgeServerGen.recent_pledges()

    %{ conv | code_status: 200, resp_body: (inspect pledges) }
  end
end
#Client
