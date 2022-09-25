defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """

  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base = String.downcase(base)
    Enum.filter(candidates, &(String.downcase(&1) |> are_anagrams?(base)))
  end

  defp are_anagrams?(word_1, word_2) do
    word_1 != word_2 and sorted_chars(word_1) == sorted_chars(word_2)
  end

  defp sorted_chars(string) do
    string
    |> String.to_charlist()
    |> Enum.sort()
  end

end
