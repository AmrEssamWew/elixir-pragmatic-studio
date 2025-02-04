defmodule Servy.Conv do
@doc """
this to define the struct that while carry all the data needed to generate the http response
"""
  defstruct method: "",
            path: "",
            code_status: nil,
            resp_body: "",
            header: %{},
            param: %{} ,
            http_version: "",
            contant_type: "text/html"


  def responed_parameters(conv), do: "#{conv.http_version} #{conv.code_status} #{status_reason(conv.code_status)}"

  defp status_reason(code) do
    %{
      200 => "OK",
      201 => "Created",
      401 => "Unauthorized",
      403 => "Forbidden",
      404 => "Not Found",
      500 => "Internal Server Error"
    }[code]
  end

end
