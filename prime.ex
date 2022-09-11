defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &(&1 + 1))
    |> Enum.reduce_while([], fn number, acc ->
      acc = add_if_prime(number, acc)
      if length(acc) == count, do: {:halt, acc}, else: {:cont, acc}
      end)
    |> Enum.at(0)
  end

  defp add_if_prime(number, prime_numbers) do
    case Enum.any?(prime_numbers, &(rem(number, &1) == 0)) do
      false -> [number | prime_numbers]
      true -> prime_numbers
    end
  end

end
