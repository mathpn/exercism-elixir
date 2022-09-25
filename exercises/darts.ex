defmodule Darts do
  alias :math, as: Math
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score(position) do
    dist = distance_to_center(position)
    cond do
      dist > 10 -> 0
      dist > 5 -> 1
      dist > 1 -> 5
      true -> 10
    end
  end

  defp distance_to_center({x, y}) do
    Math.sqrt(x ** 2 + y ** 2)
  end
end
