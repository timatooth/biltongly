defmodule BiltonglyWeb.SoilReadingControllerTest do
  use BiltonglyWeb.ConnCase

  @valid_attrs %{
    "sensor_id" => 1,
    "uptime" => 1728,
    "temperature" => 26.5,
    "moisture" => 802,
    "rssi" => -56
  }
  @invalid_attrs %{
    "sensor_id" => nil,
    "uptime" => nil,
    "temperature" => nil,
    "moisture" => nil,
    "rssi" => nil
  }

  describe "create soil_reading" do
    test "returns 201 when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/soil_readings", @valid_attrs)
      assert response(conn, 201)
    end

    test "returns 422 when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/soil_readings", @invalid_attrs)
      assert response(conn, 422)
    end

    test "actually creates the reading in the database", %{conn: conn} do
      conn = post(conn, ~p"/api/soil_readings", @valid_attrs)
      assert response(conn, 201)

      # Verify it's in the database
      reading = Biltongly.Sensors.list_soil_readings() |> List.first()
      assert reading.sensor_id == @valid_attrs["sensor_id"]
      assert reading.uptime == @valid_attrs["uptime"]
      assert reading.moisture == @valid_attrs["moisture"]
      assert reading.rssi == @valid_attrs["rssi"]
      assert reading.measured_at != nil
    end
  end
end
