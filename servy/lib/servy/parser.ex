defmodule Servy.Parser do
  @moduledoc """
  this module parses the http request
  """
  alias Servy.Conv

  @doc """
  this funcation splite the reuest to 2 parts the http headers and the paramters if found
   and parses the headers and the parameters to the struct
  """
  def parse(request) do
    request=String.replace(request, "\r", "")
    [request_top, params_line] =
    case String.split(request, "\n\n") do
      [top, line] -> [top, line]
      _ -> [request, []]
    end


    [firstline | tail] = String.split(request_top, "\n")
    [method, path, http_version] = String.split(firstline, " ")
    IO.inspect(tail)
    headers=parse_header(tail)
    param = parse_params(headers["Content-Type"],params_line)

    %Conv{method: method, path: path, code_status: nil, resp_body: "", param: param , http_version: http_version }
  end



  @doc """
  parse the prameters of the request
  ## Example
  iex> Servy.Parser.parse_params(" application/x-www-form-urlencoded","name=Baloo&type=Brown")
  %{"name"=>"Baloo" , "type"=> "Brown"}

  """

  def parse_params(" application/x-www-form-urlencoded",params_line) do
      params_line
      |> String.trim()
      |> URI.decode_query()
  end
  def parse_params(_,_),do: %{}
  defp parse_header(headers) do
     Enum.reduce(headers,%{},fn(line,header_map) ->
      [key,value] = String.split(line, ":",parts: 2)
      Map.put(header_map,key,value)
     end)
  end

end
