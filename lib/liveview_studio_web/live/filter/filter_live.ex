defmodule LiveviewStudioWeb.FilterLive do
  use LiveviewStudioWeb, :live_view

  alias LiveviewStudio.Boats

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        boats: Boats.list_boats(),
        type: "",
        prices: []
      )

    {:ok, socket}
  end

  @impl true
  def handle_event("filter", %{"type" => type}, socket) do
    boats = Boats.list_boats(type: type)

    socket = assign(socket, boats: boats, type: type)
    {:noreply, socket}
  end

  defp type_options do
    [
      "All types": "",
      Fishing: "fishing",
      Sporting: "sporting",
      Sailing: "sailing"
    ]
  end
end
