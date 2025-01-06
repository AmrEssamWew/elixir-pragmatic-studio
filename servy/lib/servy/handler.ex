defmodule Servy.Handler do
  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> rewrite_request
    |> route
    |> emojify
    |> format_response
  end

  def parse(request) do
    [method, path, _] =
      request
      |> String.split("\n")
      |> List.first()
      |> String.split(" ")

    %{method: method, path: path, code_status: nil, resp_body: ""}
  end

  def rewrite_path(%{path: "/wildlife"} = conv), do: %{conv | path: "wildthings"}
  def rewrite_path(conv), do: conv

  def rewrite_request(%{path: "bears?id=" <> id} = conv), do: %{conv | path: "bears/#{id}"}
  def rewrite_request(conv), do: conv

  def emojify(%{code_status: 200} = conv), do: %{conv | resp_body: "🎉" <> conv.resp_body <> "🎉"}
  def emojify(conv), do: conv

  def route(%{method: "GET", path: "/wildthings"} = conv) do
    %{conv | code_status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%{method: "GET", path: "/bears"} = conv) do
    %{conv | code_status: 200, resp_body: "Teddy, Smokey, Paddington"}
  end

  def route(%{method: "GET", path: "/bears/" <> id} = conv) do
    %{conv | code_status: 200, resp_body: "bear #{id}"}
  end

  def route(%{method: "DELETE", path: "/bears/" <> _id} = conv) do
    %{conv | status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def route(conv) do
    %{conv | code_status: 404, resp_body: "No path found in #{conv.path}"}
  end

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

  def format_response(%{code_status: 200}=conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 #{conv.code_status} #{status_reason(conv.code_status)}
    Content-Type: text/html
    Content-Length: #{(String.length(conv.resp_body)) -2}

    #{conv.resp_body}
    """
  end
  S


  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    HTTP/1.1 #{conv.code_status} #{status_reason(conv.code_status)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

# request = """
# GET /wildthings HTTP/1.1
# Host: example.com
# User-Agent: ExampleBrowser/1.0
# Accept: */*

# """

request = """
GET /bears/1 HTTP/1.1
Host: example1.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)
