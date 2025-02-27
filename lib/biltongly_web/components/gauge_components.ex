defmodule BiltonglyWeb.GaugeComponents do
  use Phoenix.Component

  # Center X
  @cx 150
  # Center Y
  @cy 150
  # Inner tick radius
  @r_inner 90
  # Outer tick radius
  @r_outer 100

  @doc """
  Draws a SVG gauge like in a modern commercial aircraft's engine system display

  ## Examples

      <.ecam_gauge value={5.2} />
  """
  attr :value, :float, default: 0.0, doc: "The current value of the gauge"
  attr :numbers_count, :integer, default: 4, doc: "How many number divisions"
  attr :ticks, :integer, default: 5, doc: "How many tick divisions"
  attr :min, :integer, default: 0, doc: "Min gauge value"
  attr :max, :integer, default: 100, doc: "Max gauge value"

  def ecam_gauge(assigns) do
    assigns = assign(assigns, :ticks, generate_ticks(assigns.ticks))

    assigns =
      assign(assigns, :numbers, generate_numbers(assigns.numbers_count, assigns.min, assigns.max))

    assigns =
      assign(
        assigns,
        :gauge_angle,
        calculate_gauge_angle(assigns.value, assigns.min, assigns.max)
      )

    ~H"""
    <svg width="300" height="200" viewBox="0 0 300 200" xmlns="http://www.w3.org/2000/svg">
      <style>
        .number {
          font: normal 14px monospace; 
        }
        .display {
          font: bold 18px monospace;
        }
      </style>
      <!-- White Arc -->
      <path d="M50,150 A100,100 0 0,1 246,120" stroke="grey" stroke-width="6" fill="none" />
      
    <!-- Red Arc -->
      <path d="M246,120 A100,100 0 0,1 250,150" stroke="red" stroke-width="6" fill="none" />
      
    <!-- Tick Marks -->
      <line
        :for={line <- @ticks}
        x1={line.x1}
        y1={line.y1}
        x2={line.x2}
        y2={line.y2}
        stroke="grey"
        stroke-width="3"
      />
      
    <!-- Numbers -->
      <text :for={num <- @numbers} class="number" x={num.x} y={num.y} fill="blue">{num.value}</text>
      <!-- Indicator Needle -->
      <line
        x1="150"
        y1="150"
        x2="150"
        y2="50"
        stroke="lime"
        stroke-width="3"
        transform={"rotate(#{@gauge_angle}, 150, 150)"}
      />
      <circle cx="150" cy="150" r="5" fill="lime" />
      
    <!-- Orange Marker for the setpoint -->
      <rect x="190" y="55" width="10" height="20" fill="orange" transform="rotate(30, 195, 65)" />
      
    <!-- Digital Display Box -->
      <rect x="100" y="160" width="100" height="40" fill="black" stroke="lime" stroke-width="2" />
      
    <!-- Digital Text -->
      <text class="display" x="110" y="180" fill="lime" font-weight="bold">AVAIL</text>
      <text class="display" x="150" y="195" fill="lime" font-weight="bold">{@value}</text>
    </svg>
    """
  end

  defp generate_ticks(tick_count) do
    tick_gap = 180 / (tick_count - 1)

    for i <- 0..(tick_count - 1) do
      # Convert to radians
      theta = :math.pi() * (i * tick_gap) / 180

      %{
        x1: @cx + @r_inner * :math.cos(theta),
        y1: @cy - @r_inner * :math.sin(theta),
        x2: @cx + @r_outer * :math.cos(theta),
        y2: @cy - @r_outer * :math.sin(theta)
      }
    end
  end

  defp generate_numbers(number_count, gauge_min, gauge_max) do
    number_gap = 180 / (number_count - 1)

    gauge_range = gauge_max - gauge_min

    for i <- 0..(number_count - 1) do
      # Convert to radians
      theta = :math.pi() * (i * number_gap) / 180
      number = gauge_max - gauge_range / (number_count - 1) * i
      number = Float.round(number, 1)

      %{
        x: @cx + (@r_inner + 30) * :math.cos(theta),
        y: @cy - (@r_inner + 30) * :math.sin(theta),
        value: number
      }
    end
  end

  defp calculate_gauge_angle(value, min, max) do
    -90 + (value - min) * 180 / (max - min)
  end
end
