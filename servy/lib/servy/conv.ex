defmodule Servy.Conv do

  defstruct method: "",
            path: "",
            code_status: nil,
            resp_body: "",
            param: %{} ,
            http_version: ""

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
