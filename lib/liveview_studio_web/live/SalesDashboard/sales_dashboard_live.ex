defmodule LiveviewStudioWeb.SalesDashboardLive do
  use LiveviewStudioWeb, :live_view

  alias LiveviewStudio.Sales

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assign_stats(socket)}
  end

  @impl true
  def handle_event("refresh", _payload, socket) do
    {:noreply, assign_stats(socket)}
  end

  @impl true
  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket,
      new_orders: Sales.new_orders(),
      sales_amount: Sales.sales_amount(),
      satisfaction: Sales.satisfaction()
    )
  end
end
