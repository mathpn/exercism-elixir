defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}

  def convert(digits, input_base, output_base) do
    if Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      {:ok, digits |> to_decimal(input_base) |> from_decimal(output_base)}
    end
  end

  defp to_decimal(digits, input_base) do
    Enum.reduce(digits, 0, fn digit, acc -> acc * input_base + digit end)
  end

  defp from_decimal(number, base, acc \\ [])
  defp from_decimal(number, base, acc) when number < base, do: [number | acc]
  defp from_decimal(number, base, acc) do
    from_decimal(div(number, base), base, [rem(number, base) | acc])
  end

end
