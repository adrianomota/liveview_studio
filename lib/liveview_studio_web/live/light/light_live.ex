defmodule LiveviewStudioWeb.LightLive do
  use LiveviewStudioWeb, :live_view


  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    {:ok, socket}
  end

  @impl true
  def handle_event("more", _payload, socket) do
    # brightness = socket.assigns.brightness + 10
    if socket.assigns.brightness <= 90 do
      socket = update(socket, :brightness, &(&1 + 10))
      {:noreply, socket}
    else
      socket = assign(socket, :brightness, 100)
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("less", _payload, socket) do
    if socket.assigns.brightness >= 10 do
      socket = update(socket, :brightness, &(&1 - 10))
      {:noreply, socket}
    else
      socket = assign(socket, :brightness, 0)
      {:noreply, socket}
    end
  end
end
