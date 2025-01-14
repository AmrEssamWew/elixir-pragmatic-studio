defmodule PledgeServerTest do
  use ExUnit.Case

  import Servy.PledgeServer, only: [start_server: 0,create_pledge: 2 ,recent_pledges: 0]

  test "Post 3 requestes and get the cached values" do
    start_server()
    create_pledge("Amr",100)
    create_pledge("Essam",200)
    create_pledge("Mohamed",300)
    result=recent_pledges()
    assert result == [{"Mohamed",300},{"Essam",200},{"Amr",100}]

  end
end
