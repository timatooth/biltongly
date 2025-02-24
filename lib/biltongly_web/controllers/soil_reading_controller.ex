defmodule BiltonglyWeb.SoilReadingController do
  use BiltonglyWeb, :controller

  alias Biltongly.Sensors

  def create(conn, params) do
    transformed_params =
      params
      |> Map.put("measured_at", DateTime.utc_now())
      |> Map.put("sensor_id", params["id"])
      |> Map.delete("id")

    case Sensors.create_soil_reading(transformed_params) do
      {:ok, _soil_reading} ->
        send_resp(conn, :created, "")

      {:error, _changeset} ->
        send_resp(conn, :unprocessable_entity, "")
    end
  end
end
