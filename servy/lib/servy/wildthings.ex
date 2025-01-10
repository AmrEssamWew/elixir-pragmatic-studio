defmodule Servy.Wildthings do
  alias Servy.Bears

  def list_bears do
    [
      %Bears{id: 1, name: "Teddy", type: "Brown", hibernating: true},
      %Bears{id: 2, name: "Smokey", type: "Black"},
      %Bears{id: 3, name: "Paddington", type: "Brown"},
      %Bears{id: 4, name: "Scarface", type: "Grizzly", hibernating: true},
      %Bears{id: 5, name: "Snow", type: "Polar"},
      %Bears{id: 6, name: "Brutus", type: "Grizzly"},
      %Bears{id: 7, name: "Rosie", type: "Black", hibernating: true},
      %Bears{id: 8, name: "Roscoe", type: "Panda"},
      %Bears{id: 9, name: "Iceman", type: "Polar", hibernating: true},
      %Bears{id: 10, name: "Kenai", type: "Grizzly"}
    ]
  end

end
