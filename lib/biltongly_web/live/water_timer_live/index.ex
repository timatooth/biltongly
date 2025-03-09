defmodule BiltonglyWeb.WaterTimerLive.Index do
  use BiltonglyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    initial_state = %{
      devices: []
    }

    if connected?(socket) do
      # In real implementation, subscribe to PubSub topics
      # Phoenix.PubSub.subscribe(Biltong.PubSub, "biltong:metrics")
    end

    {:ok, assign(socket, initial_state), layout: {BiltonglyWeb.Layouts, :root}}
  end
end
