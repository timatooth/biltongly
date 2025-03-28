defmodule BiltonglyWeb.CartLive.Index do
  use BiltonglyWeb, :live_view

  alias Biltongly.Shopping
  alias Biltongly.Shopping.Cart

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :cart_collection, Shopping.list_cart())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cart")
    |> assign(:cart, Shopping.get_cart!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cart")
    |> assign(:cart, %Cart{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Cart")
    |> assign(:cart, nil)
  end

  @impl true
  def handle_info({BiltonglyWeb.CartLive.FormComponent, {:saved, cart}}, socket) do
    {:noreply, stream_insert(socket, :cart_collection, cart)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cart = Shopping.get_cart!(id)
    {:ok, _} = Shopping.delete_cart(cart)

    {:noreply, stream_delete(socket, :cart_collection, cart)}
  end
end
