defmodule Biltongly.SensorsTest do
  use Biltongly.DataCase

  alias Biltongly.Sensors

  describe "soil_readings" do
    alias Biltongly.Sensors.SoilReading

    import Biltongly.SensorsFixtures

    @invalid_attrs %{
      uptime: nil,
      sensor_id: nil,
      temperature: nil,
      moisture: nil,
      rssi: nil,
      measured_at: nil
    }

    test "list_soil_readings/0 returns all soil_readings" do
      soil_reading = soil_reading_fixture()
      assert Sensors.list_soil_readings() == [soil_reading]
    end

    test "get_soil_reading!/1 returns the soil_reading with given id" do
      soil_reading = soil_reading_fixture()
      assert Sensors.get_soil_reading!(soil_reading.id) == soil_reading
    end

    test "create_soil_reading/1 with valid data creates a soil_reading" do
      valid_attrs = %{
        uptime: 42,
        sensor_id: 42,
        temperature: "120.5",
        moisture: 42,
        rssi: 42,
        measured_at: ~N[2025-02-23 06:38:00]
      }

      assert {:ok, %SoilReading{} = soil_reading} = Sensors.create_soil_reading(valid_attrs)
      assert soil_reading.uptime == 42
      assert soil_reading.sensor_id == 42
      assert soil_reading.temperature == Decimal.new("120.5")
      assert soil_reading.moisture == 42
      assert soil_reading.rssi == 42
      assert soil_reading.measured_at == ~N[2025-02-23 06:38:00]
    end

    test "create_soil_reading/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sensors.create_soil_reading(@invalid_attrs)
    end

    test "update_soil_reading/2 with valid data updates the soil_reading" do
      soil_reading = soil_reading_fixture()

      update_attrs = %{
        uptime: 43,
        sensor_id: 43,
        temperature: "456.7",
        moisture: 43,
        rssi: 43,
        measured_at: ~N[2025-02-24 06:38:00]
      }

      assert {:ok, %SoilReading{} = soil_reading} =
               Sensors.update_soil_reading(soil_reading, update_attrs)

      assert soil_reading.uptime == 43
      assert soil_reading.sensor_id == 43
      assert soil_reading.temperature == Decimal.new("456.7")
      assert soil_reading.moisture == 43
      assert soil_reading.rssi == 43
      assert soil_reading.measured_at == ~N[2025-02-24 06:38:00]
    end

    test "update_soil_reading/2 with invalid data returns error changeset" do
      soil_reading = soil_reading_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sensors.update_soil_reading(soil_reading, @invalid_attrs)

      assert soil_reading == Sensors.get_soil_reading!(soil_reading.id)
    end

    test "delete_soil_reading/1 deletes the soil_reading" do
      soil_reading = soil_reading_fixture()
      assert {:ok, %SoilReading{}} = Sensors.delete_soil_reading(soil_reading)
      assert_raise Ecto.NoResultsError, fn -> Sensors.get_soil_reading!(soil_reading.id) end
    end

    test "change_soil_reading/1 returns a soil_reading changeset" do
      soil_reading = soil_reading_fixture()
      assert %Ecto.Changeset{} = Sensors.change_soil_reading(soil_reading)
    end
  end

  # describe "soil_readings" do
  #   alias Biltongly.Sensors.SoilReading

  #   import Biltongly.SensorsFixtures

  #   @invalid_attrs %{uptime: nil, sensor_id: nil, temperature: nil, moisture: nil, rssi: nil, measured_at: nil}

  #   test "list_soil_readings/0 returns all soil_readings" do
  #     soil_reading = soil_reading_fixture()
  #     assert Sensors.list_soil_readings() == [soil_reading]
  #   end

  #   test "get_soil_reading!/1 returns the soil_reading with given id" do
  #     soil_reading = soil_reading_fixture()
  #     assert Sensors.get_soil_reading!(soil_reading.id) == soil_reading
  #   end

  #   test "create_soil_reading/1 with valid data creates a soil_reading" do
  #     valid_attrs = %{uptime: 42, sensor_id: 42, temperature: "120.5", moisture: 42, rssi: 42, measured_at: ~N[2025-02-23 06:40:00]}

  #     assert {:ok, %SoilReading{} = soil_reading} = Sensors.create_soil_reading(valid_attrs)
  #     assert soil_reading.uptime == 42
  #     assert soil_reading.sensor_id == 42
  #     assert soil_reading.temperature == Decimal.new("120.5")
  #     assert soil_reading.moisture == 42
  #     assert soil_reading.rssi == 42
  #     assert soil_reading.measured_at == ~N[2025-02-23 06:40:00]
  #   end

  #   test "create_soil_reading/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Sensors.create_soil_reading(@invalid_attrs)
  #   end

  #   test "update_soil_reading/2 with valid data updates the soil_reading" do
  #     soil_reading = soil_reading_fixture()
  #     update_attrs = %{uptime: 43, sensor_id: 43, temperature: "456.7", moisture: 43, rssi: 43, measured_at: ~N[2025-02-24 06:40:00]}

  #     assert {:ok, %SoilReading{} = soil_reading} = Sensors.update_soil_reading(soil_reading, update_attrs)
  #     assert soil_reading.uptime == 43
  #     assert soil_reading.sensor_id == 43
  #     assert soil_reading.temperature == Decimal.new("456.7")
  #     assert soil_reading.moisture == 43
  #     assert soil_reading.rssi == 43
  #     assert soil_reading.measured_at == ~N[2025-02-24 06:40:00]
  #   end

  #   test "update_soil_reading/2 with invalid data returns error changeset" do
  #     soil_reading = soil_reading_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Sensors.update_soil_reading(soil_reading, @invalid_attrs)
  #     assert soil_reading == Sensors.get_soil_reading!(soil_reading.id)
  #   end

  #   test "delete_soil_reading/1 deletes the soil_reading" do
  #     soil_reading = soil_reading_fixture()
  #     assert {:ok, %SoilReading{}} = Sensors.delete_soil_reading(soil_reading)
  #     assert_raise Ecto.NoResultsError, fn -> Sensors.get_soil_reading!(soil_reading.id) end
  #   end

  #   test "change_soil_reading/1 returns a soil_reading changeset" do
  #     soil_reading = soil_reading_fixture()
  #     assert %Ecto.Changeset{} = Sensors.change_soil_reading(soil_reading)
  #   end
  # end
end
