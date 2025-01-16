defmodule Servy.APIs.BearsAPI do
  @moduledoc """
    This module simulates an API controller using Poison libarary to convert the bears lists into jason object

  """
alias Servy.Wildthings
@doc """
fetching the bear lists and convert them into jason
"""
def index(conv) do

    bears_list=Wildthings.list_bears()
              #  |> Enum.sort(&(&1 <= &2))

  %{conv | code_status: 200,contant_type: "application/json" ,resp_body: Poison.encode!(bears_list)}
  end
  @doc """
fetching a specfic bear list by id and convert it into jason
"""
  def index(conv,id) when is_integer(id) do
    bear=Wildthings.list_bears()
         |> Enum.find(&(&1.id==id))
  %{conv | code_status: 200, resp_body: Poison.encode!(bear)}
  end


  def index(conv,id) when is_binary(id) do
    #  converting the givein id value to integer value
    id=String.to_integer(id)
    index(conv,id)
  end
end
