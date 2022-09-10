defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) do
    do_calculation(input)
  end

  defp do_calculation(number, steps \\ 0)
  defp do_calculation(1, steps), do: steps
  defp do_calculation(number, steps) when rem(number, 2) == 0 and number > 0 do
    do_calculation(div(number, 2), steps + 1)
  end
  defp do_calculation(number, steps) when number > 0 do
    do_calculation(number * 3 + 1, steps + 1)
  end

end
