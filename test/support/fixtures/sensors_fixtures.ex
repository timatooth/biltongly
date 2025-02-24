defmodule Biltongly.SensorsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Biltongly.Sensors` context.
  """

  @doc """
  Generate a soil_reading.
  """
  def soil_reading_fixture(attrs \\ %{}) do
    {:ok, soil_reading} =
      attrs
      |> Enum.into(%{
        measured_at: ~N[2025-02-23 06:38:00],
        moisture: 42,
        rssi: 42,
        sensor_id: 42,
        temperature: "120.5",
        uptime: 42
      })
      |> Biltongly.Sensors.create_soil_reading()

    soil_reading
  end
end
