defmodule Biltongly.BhyveServer do
  @moduledoc """
    This is a bridging server between the Orbit B-Hyve servers REST and websocket system and Phoenix pubsub
  """
  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state)
  end

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_call(:get_programs, _from, state) do
    token = Application.get_env(:biltongly, Biltongly.BhyveServer)[:orbit_session_token]

    Req.get("https://api.orbitbhyve.com/v1/sprinkler_timer_programs",
      headers: [
        {"Orbit-Session-Token", token},
        {"Origin", "https://my.orbitbhyve.com"},
        {"Referer", "https://my.orbitbhyve.com/"}
      ]
    )

    {:reply, state, state}
  end

  def handle_cast({:update_state, new_state}, _state) do
    {:noreply, new_state}
  end
end
