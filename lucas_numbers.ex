defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(1) do
    [2]
  end

  def generate(2) do
    [2, 1]
  end

  def generate(count) when is_integer(count) and count > 2 do
    Stream.iterate({2, 1}, fn {a, b} -> {b, a + b} end)
    |> Stream.map(&elem(&1, 0))
    |> Enum.take(count)
  end

  def generate(_) do
    raise(ArgumentError, "count must be specified as an integer >= 1")
  end

end
