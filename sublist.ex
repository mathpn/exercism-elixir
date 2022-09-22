defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal
  def compare(a, b) do
    cond do
      subset?(a, b) -> :sublist
      subset?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp subset?([], _), do: true
  defp subset?(_, []), do: false
  defp subset?(a, b) do
    b |> Enum.chunk_every(length(a), 1) |> Enum.any?(& &1 === a)
  end

end
