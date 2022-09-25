# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> {1, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, plots} -> plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {current_id, plots} ->
      next_id = current_id + 1
      new_plot = %Plot{plot_id: next_id, registered_to: register_to}
      state = {next_id, [new_plot | plots]}
      {new_plot, state}
      end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {current_id, plots} ->
      {
        current_id,
        Enum.filter(plots, &(&1.plot_id != plot_id))
      }
      end
    )
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn {_, plots} ->
      Enum.find(plots, {:not_found, "plot is unregistered"}, &(&1.plot_id == plot_id))
      end
    )
  end
end
