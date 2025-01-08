defmodule Servy.Handler do
  import Servy.Parser, only: [parse: 1]
  import Servy.Plugins, only: [emojify: 1]
  import Servy.Filehandler, only: [handle_file: 2]
  alias Servy.Conv

  @pages_path Path.expand("../../Pages", __DIR__)
  def handle(request) do
    request
    |> parse
    |> rewrite_path
    |> rewrite_request
    |> route
    |> emojify
    |> format_response
  end

  def rewrite_path(%Conv{path: "/wildlife"} = conv), do: %{conv | path: "/wildthings"}
  def rewrite_path(conv), do: conv

  def rewrite_request(%Conv{path: "bears?id=" <> id} = conv), do: %{conv | path: "bears/#{id}"}
  def rewrite_request(conv), do: conv

  def route(%Conv{method: "GET", path: "/wildthings"} = conv) do
    %{conv | code_status: 200, resp_body: "Bears, Lions, Tigers"}
  end

  def route(%Conv{method: "GET", path: "/bears"} = conv) do
    %{conv | code_status: 200, resp_body: "Teddy, Smokey, Paddington"}
  end

  def route(%Conv{method: "GET", path: "/bears/" <> id} = conv) do
    %{conv | code_status: 200, resp_body: "bear #{id}"}
  end

  def route(%Conv{method: "DELETE", path: "/bears/" <> _id} = conv) do
    %{conv | code_status: 403, resp_body: "Deleting a bear is forbidden!"}
  end

  def route(%Conv{method: "GET", path: "/about"} = conv) do
    Path.join(@pages_path, "about.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "GET", path: "bears/new"} = conv) do
    Path.join(@pages_path, "form.html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{path: "/pages" <> page} = conv) do
    Path.join(@pages_path, page <> ".html")
    |> File.read()
    |> handle_file(conv)
  end

  def route(%Conv{method: "POST", path: "/bears"} = conv) do
    %{ conv | code_status: 201, resp_body: "Create a #{conv.param["type"]} bear called #{conv.param["name"]}" }
  end
  def route(conv) do
    %{conv | code_status: 404, resp_body: "No path found in #{conv.path}"}
  end



  def format_response(%Conv{code_status: 200} = conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    #{Conv.responed_parameters(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body) - 2}

    #{conv.resp_body}
    """
  end

  def format_response(conv) do
    # TODO: Use values in the map to create an HTTP response string:
    """
    #{Conv.responed_parameters(conv)}
    Content-Type: text/html
    Content-Length: #{String.length(conv.resp_body)}

    #{conv.resp_body}
    """
  end
end

request = """
GET /wildthings HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /bigfoot HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /bears/1 HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /wildlife HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /about HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
GET /pages/contact HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*

"""

response = Servy.Handler.handle(request)

IO.puts(response)

request = """
POST /bears HTTP/1.1
Host: example.com
User-Agent: ExampleBrowser/1.0
Accept: */*
Content-Type: application/x-www-form-urlencoded
Content-Length: 21

name=Baloo&type=Brown
"""

response = Servy.Handler.handle(request)

IO.puts(response)
