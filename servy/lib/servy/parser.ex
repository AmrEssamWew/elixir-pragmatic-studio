defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    [request_top, params_line] =
      request
      |> String.split("\n\n")

    param = parse_params(params_line)

    [firstline | _tail] = String.split(request_top, "\n")
    [method, path, http_version] = String.split(firstline, " ")

    %Conv{method: method, path: path, code_status: nil, resp_body: "", param: param , http_version: http_version}
  end

  defp parse_params(params_line) do
      params_line
      |> String.trim()
      |> URI.decode_query()
  end
end
