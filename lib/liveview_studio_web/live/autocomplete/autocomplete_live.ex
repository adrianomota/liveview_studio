defmodule LiveviewStudioWeb.AutocompleteLive do
  use LiveviewStudioWeb, :live_view

  alias LiveviewStudio.{Cities, Stores}

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        city: "",
        stores: [],
        matches: [],
        loading: false
      )

    {:ok, socket}
  end

  @impl true
  def handle_event("zip-search", %{"zip" => zip}, socket) do
    send(self(), {:run_zip_search, zip})

    socket =
      assign(socket,
        zip: zip,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  def handle_event("city-search", %{"city" => city}, socket) do
    send(self(), {:run_city_search, city})

    socket =
      assign(socket,
        city: city,
        stores: [],
        loading: true
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("suggest-city", %{"city" => prefix}, socket) do
    socket = assign(socket, matches: Cities.suggest(prefix))
    {:noreply, socket}
  end

  @impl true
  def handle_info({:run_zip_search, zip}, socket) do
    case Stores.search_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{zip}\"")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)

        {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:run_city_search, city}, socket) do
    case Stores.search_by_city(city) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{city}\"")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket = assign(socket, stores: stores, loading: false)

        {:noreply, socket}
    end
  end
end
