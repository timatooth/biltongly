defmodule BiltonglyWeb.BoxLive.Index do
  use BiltonglyWeb, :live_view
  import BiltonglyWeb.GaugeComponents

  @impl true
  def mount(_params, _session, socket) do
    # Node.connect(:"nerves@fdaa:0:c3b7:a7b:9076:0:a:902")

    reading = Biltongly.Sensors.get_latest_soil_reading()

    initial_state = %{
      temperature: 25.4,
      temp_graph: create_graph(),
      humidity: 65.2,
      light_status: true,
      fan_speed: 75,
      temp_setpoint: 26.0,
      humidity_setpoint: 70.0,
      temp_alert_range: {20, 30},
      humidity_alert_range: {60, 75},
      camera_url: "/images/biltong-action.jpeg",
      timelapse_position: 0,
      connected?: true,
      latest_update: DateTime.utc_now(),
      doneness_percent: 45,
      # Enum.random([:low, :medium, :high])
      ant_risk_level: :low,
      soil_rssi: reading.rssi,
      soil_temperature: Decimal.to_float(reading.temperature),
      soil_moisture: reading.moisture
    }

    if connected?(socket) do
      # In real implementation, subscribe to PubSub topics
      # Phoenix.PubSub.subscribe(Biltong.PubSub, "biltong:metrics")
    end

    Process.send_after(self(), :update_ant_risk_level, 5_000)

    {:ok, assign(socket, initial_state), layout: {BiltonglyWeb.Layouts, :root}}
  end

  @impl true
  def handle_event(
        "temp_change",
        %{"_target" => ["temp_setpoint"], "temp_setpoint" => temp_string},
        socket
      ) do
    {value, _} = Float.parse(temp_string)

    {:noreply,
     assign(socket,
       temp_setpoint: value
     )}
  end

  # Add a handle_info callback to update the ant risk level
  # every 5 seconds
  @impl true
  def handle_info(:update_ant_risk_level, socket) do
    new_risk_level = Enum.random([:low, :medium, :high])

    # {:ok, temperature} =
    #   GenServer.call(
    #     {HelloNerves.TemperatureServer, :"nerves@fdaa:0:c3b7:a7b:9076:0:a:902"},
    #     :get_temperature
    #   )

    # Schedule another update. God this is silly
    Process.send_after(self(), :update_ant_risk_level, 5_000)

    reading = Biltongly.Sensors.get_latest_soil_reading()

    {:noreply,
     assign(socket,
       ant_risk_level: new_risk_level,
       soil_temperature: Decimal.to_float(reading.temperature),
       soil_moisture: reading.moisture
     )}
  end

  defp create_graph() do
    result =
      Biltongly.Repo.query!(
        ~S"""
        WITH hourly_averages AS (
            SELECT
                sensor_id,
                count(sensor_id) as hourly_sample_count,
                date_trunc('hour', measured_at) AS observation_hour,
                AVG(temperature) AS hourly_avg_temperature,
                AVG(moisture) AS hourly_avg_moisture
            FROM
                soil_readings
            GROUP BY
                sensor_id, observation_hour
        )
        select * from hourly_averages order by observation_hour desc;
        """,
        []
      )

    graph =
      VegaLite.new(width: 500, background: "orange")
      |> VegaLite.data_from_values(result,
        only: ["observation_hour", "hourly_avg_temperature"]
      )
      |> VegaLite.mark(:point, tooltip: true)
      |> VegaLite.encode_field(:x, "observation_hour", type: :temporal)
      |> VegaLite.encode_field(:y, "hourly_avg_temperature", type: :quantitative)
      |> VegaLite.param("name", select: "interval", bind: "scales")

    VegaLite.Convert.to_svg(graph)
  end
end
