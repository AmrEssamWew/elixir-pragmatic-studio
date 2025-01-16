defmodule Servy.Plugins do
  @doc """
  This module is used to add this 🎉 before and after the response body
  """
  alias Servy.Conv

  def emojify(%Conv{code_status: 200} = conv), do: %{conv | resp_body: "🎉" <> conv.resp_body <> "🎉"}
  def emojify(conv), do: conv
end
