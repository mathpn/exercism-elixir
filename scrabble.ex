defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.map(&get_score/1)
    |> Enum.sum()
  end

  defp get_score(letter) when letter in 'aeioulnrst', do: 1
  defp get_score(letter) when letter in 'dg', do: 2
  defp get_score(letter) when letter in 'bcmp', do: 3
  defp get_score(letter) when letter in 'fhvwy', do: 4
  defp get_score(letter) when letter in 'jx', do: 8
  defp get_score(letter) when letter in 'qz', do: 10
  defp get_score(?k), do: 5
  defp get_score(_), do: 0

end
