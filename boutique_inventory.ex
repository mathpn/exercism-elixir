defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    get_price = fn mapping -> mapping[:price] end
    Enum.sort_by(inventory, get_price)
  end
  def with_missing_price(inventory) do
    missing_price = fn mapping -> mapping[:price] == nil end
    Enum.filter(inventory, missing_price)
  end
  def update_names(inventory, old_word, new_word) do
    replace_name = fn mapping ->
      Map.put(mapping, :name, String.replace(mapping[:name], old_word, new_word))
    end
    Enum.map(inventory, replace_name)
  end
  def increase_quantity(item, count) do
    new_quantities = Map.new(item[:quantity_by_size], fn {k, v} -> {k, v + count} end)
    Map.replace!(item, :quantity_by_size, new_quantities)
  end
  def total_quantity(item) do
    Enum.reduce(item[:quantity_by_size], 0, fn {_, v}, acc -> acc + v end)
  end
end
