defmodule Servy.Wildthings do
  alias Servy.Bears

  def list_bears do
    [
      %Bears{id: 1, name: "Teddy", type: "Brown", hibernating: true},
      %Bears{id: 2, name: "Smokey", type: "Black",hibernating: false},
      %Bears{id: 3, name: "Paddington", type: "Brown",hibernating: false},
      %Bears{id: 4, name: "Scarface", type: "Grizzly", hibernating: true},
      %Bears{id: 5, name: "Snow", type: "Polar",hibernating: false},
      %Bears{id: 6, name: "Brutus", type: "Grizzly",hibernating: false},
      %Bears{id: 7, name: "Rosie", type: "Black", hibernating: true},
      %Bears{id: 8, name: "Roscoe", type: "Panda",hibernating: false},
      %Bears{id: 9, name: "Iceman", type: "Polar", hibernating: true},
      %Bears{id: 10, name: "Kenai", type: "Grizzly",hibernating: false}
    ]
  end

end
