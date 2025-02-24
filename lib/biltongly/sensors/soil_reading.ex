defmodule Biltongly.Sensors.SoilReading do
  use Ecto.Schema
  import Ecto.Changeset

  schema "soil_readings" do
    field :uptime, :integer
    field :sensor_id, :integer
    field :temperature, :decimal
    field :moisture, :integer
    field :rssi, :integer
    field :measured_at, :naive_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(soil_reading, attrs) do
    soil_reading
    |> cast(attrs, [:sensor_id, :uptime, :temperature, :moisture, :rssi, :measured_at])
    |> validate_required([:sensor_id, :uptime, :temperature, :moisture, :rssi, :measured_at])
  end
end
