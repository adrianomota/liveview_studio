defmodule LiveviewStudioWeb.LicenseLive do
  use LiveviewStudioWeb, :live_view

  alias LiveviewStudio.Licenses

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, seats: 3, amount: Licenses.calculate(3))
    {:ok, socket}
  end

  @impl true
  def handle_event("update", %{"seats" => seats}, socket) do
    seats = String.to_integer(seats)

    socket =
      assign(socket,
        seats: seats,
        amount: Licenses.calculate(seats)
      )

    {:noreply, socket}
  end
end
