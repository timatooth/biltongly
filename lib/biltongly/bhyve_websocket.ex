defmodule Biltongly.BhyveWebsocket do
  use WebSockex

  def start_link(state) do
    WebSockex.start_link("wss://api.orbitbhyve.com/v1/events", __MODULE__, state)
    {:ok, self()}
  end

  def handle_connect(_conn, state) do
    IO.puts("Connected to websocket")
    token = Application.get_env(:biltongly, Biltongly.BhyveServer)[:orbit_session_token]
    # send a message to add the token
    message = %{
      event: "app_connection",
      orbit_session_token: token
    }

    # WebSockex.send_frame(self(), {:text, Jason.encode!(message)})
    {:ok, state}
  end

  def handle_frame({type, msg}, state) do
    IO.puts("Received Message - Type: #{inspect(type)} -- Message: #{inspect(msg)}")
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts("Sending #{type} frame with payload: #{msg}")
    {:reply, frame, state}
  end
end
