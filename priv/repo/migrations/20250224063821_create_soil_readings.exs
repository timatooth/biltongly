defmodule Biltongly.Repo.Migrations.CreateSoilReadings do
  use Ecto.Migration

  def change do
    create table(:soil_readings) do
      add :sensor_id, :integer
      add :uptime, :integer
      add :temperature, :decimal
      add :moisture, :integer
      add :rssi, :integer
      add :measured_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
