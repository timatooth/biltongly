defmodule BiltonglyWeb.SoilReadingController do
  use BiltonglyWeb, :controller

  alias Biltongly.Sensors

  def create(conn, params) do
    params_with_timestamp = Map.put(params, "measured_at", DateTime.utc_now())

    case Sensors.create_soil_reading(params_with_timestamp) do
      {:ok, _soil_reading} ->
        send_resp(conn, :created, "")

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
