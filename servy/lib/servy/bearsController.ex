defmodule Servy.Bears do
  alias Servy.BearsView
  alias Servy.Wildthings

  defstruct id: 0,
            name: "",
            type: "",
            hibernating: true



  def index(%{param: %{id: id}} = conv) do
    %{conv | code_status: 200, resp_body: BearsView.show(fetch_Bear_by_id(id))}
  end

  def index(conv) do
    %{conv | code_status: 200, resp_body: BearsView.index(fetch_bears_list())}
  end

  defp fetch_bears_list() do
    Wildthings.list_bears()
    |> Enum.sort(&(&1.name <= &2.name))
  end

  defp fetch_Bear_by_id(id) when is_integer(id) do
    Wildthings.list_bears()
    |> Enum.find(&(&1.id == id))
  end

  defp fetch_Bear_by_id(id) when is_binary(id) do
     String.to_integer(id)
    |> fetch_Bear_by_id
  end
end
