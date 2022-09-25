defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer
  @callback init(opts :: opts) :: tuple
  @callback handle_frame(dot :: dot, frame_number :: frame_number, options :: opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _options) do
    opacity = case rem(frame_number, 4) do
      0 -> dot.opacity / 2
      _ -> dot.opacity
    end
    %{dot | opacity: opacity}
  end

end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    case Keyword.fetch(opts, :velocity) do
      {:ok, velocity} when is_number(velocity) -> {:ok, opts}
      {:ok, velocity} -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
      :error -> {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(nil)}"}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, options) do
    radius = dot.radius + (frame_number - 1) * options[:velocity]
    %{dot | radius: radius}
  end

end
