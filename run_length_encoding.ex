defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string |> String.graphemes() |> do_encoding()
  end

  defp do_encoding(characters, encoded \\ "", count \\ 1)
  defp do_encoding([], _, _), do: ""
  defp do_encoding([char | tail], encoded, count) do
    case tail do
      [next_char | _] when char == next_char -> do_encoding(tail, encoded, count + 1)
      [_next_char | _] -> do_encoding(tail, encode_string(encoded, char, count))
      [] -> encode_string(encoded, char, count)
    end
  end

  defp encode_string(encoded, char, count) do
    cond do
      count > 1 -> encoded <> "#{count}#{char}"
      true -> encoded <> "#{char}"
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r/(?<numbers>\d*)(?<char>[a-zA-Z\s])/, string) |> do_decode()
  end

  defp do_decode(regex_captures, decoded \\ "") do
    case regex_captures do
      [[_, count, char] | tail] when count == "" ->
        do_decode(tail, decode_string(decoded, char, 1))
      [[_, count, char] | tail] ->
        do_decode(tail, decode_string(decoded, char, String.to_integer(count)))
      [] -> decoded
    end    
  end

  defp decode_string(decoded, char, count), do: decoded <> String.duplicate(char, count)

end
