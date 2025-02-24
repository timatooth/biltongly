defmodule BiltonglyWeb.SoilReadingJSON do
  alias Biltongly.Sensors.SoilReading

  @doc """
  Renders a list of soil_readings.
  """
  def index(%{soil_readings: soil_readings}) do
    %{data: for(soil_reading <- soil_readings, do: data(soil_reading))}
  end

  @doc """
  Renders a single soil_reading.
  """
  def show(%{soil_reading: soil_reading}) do
    %{data: data(soil_reading)}
  end

  defp data(%SoilReading{} = soil_reading) do
    %{
      id: soil_reading.id,
      sensor_id: soil_reading.sensor_id,
      uptime: soil_reading.uptime,
      temperature: soil_reading.temperature,
      moisture: soil_reading.moisture,
      rssi: soil_reading.rssi,
      measured_at: soil_reading.measured_at
    }
  end
end
