defmodule BiltonglyWeb.CartLive.Show do
  use BiltonglyWeb, :live_view

  alias Biltongly.Shopping

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cart, Shopping.get_cart!(id))}
  end

  defp page_title(:show), do: "Show Cart"
  defp page_title(:edit), do: "Edit Cart"
end
