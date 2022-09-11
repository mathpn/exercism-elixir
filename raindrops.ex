defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @factor_sounds [
    {3, "Pling"},
    {5, "Plang"},
    {7, "Plong"},
  ]
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    case for {factor, sound} <- @factor_sounds, into: "", do: add_sound(number, factor, sound) do
      "" -> number |> Integer.to_string()
      string -> string
    end
  end

  defp add_sound(integer, factor, sound) do
    case rem(integer, factor) do
      0 -> sound
      _ -> ""
    end
  end
end
