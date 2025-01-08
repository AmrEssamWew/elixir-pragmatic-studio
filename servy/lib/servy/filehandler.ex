defmodule Servy.Filehandler do
  alias Servy.Conv

  def handle_file({:ok, contant}, conv) do
    %Conv{conv | code_status: 200, resp_body: contant}
  end

  def handle_file({:error, :enoent}, conv) do
    %Conv{conv | code_status: 404, resp_body: "File not found!"}
  end

  def handle_file({:error, reason}, conv) do
    %Conv{conv | code_status: 500, resp_body: "failed to find file #{reason}"}
  end
end
