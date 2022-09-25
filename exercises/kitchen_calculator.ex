defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    elem(volume_pair, 1)
  end

  def to_milliliter(volume_pair) when elem(volume_pair, 0) == :milliliter do
    {:milliliter, elem(volume_pair, 1)}
  end

  def to_milliliter(volume_pair) when elem(volume_pair, 0) == :cup do
    {:milliliter, elem(volume_pair, 1) * 240}
  end
