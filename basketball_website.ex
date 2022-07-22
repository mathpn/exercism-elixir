defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    get_by_keys(data, keys)
  end
  defp get_by_keys(data, [key | tail]) do
    data = data[key]
    get_by_keys(data, tail)
  end
  defp get_by_keys(data, []) do
    data
  end
  def get_in_path(data, path) do
    keys = String.split(path, ".")
    Kernel.get_in(data, keys)
  end
end
