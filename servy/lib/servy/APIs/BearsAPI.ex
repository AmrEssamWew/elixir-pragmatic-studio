defmodule Servy.APIs.BearsAPI do
alias Servy.Wildthings
  def index(conv) do
    bears_list=Wildthings.list_bears()
              #  |> Enum.sort(&(&1 <= &2))

  %{conv | code_status: 200,contant_type: "application/json" ,resp_body: Poison.encode!(bears_list)}
  end
  def index(conv,id) when is_integer(id) do
    bear=Wildthings.list_bears()
         |> Enum.find(&(&1.id==id))
  %{conv | code_status: 200, resp_body: Poison.encode!(bear)}
  end
  def index(conv,id) when is_binary(id) do
    id=String.to_integer(id)
    index(conv,id)
  end
end
