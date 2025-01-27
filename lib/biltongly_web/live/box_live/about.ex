defmodule BiltonglyWeb.BoxLive.About do
  use BiltonglyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    IO.puts("mouting BoxLive.About")
    {:ok, socket}
  end
end
