defmodule SecretHandshake do
  import Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @secret_commands [
    {8, "jump"},
    {4, "close your eyes"},
    {2, "double blink"},
    {1, "wink"},
    {16, :reverse},
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @secret_commands
    |> Enum.reduce([], fn {number, command}, acc -> decode(code, number, command, acc) end)
  end

  defp decode(code, number, :reverse, command_list) when (code &&& number) > 0, do: Enum.reverse(command_list)  
  defp decode(code, number, command, command_list) when (code &&& number) > 0, do: [command | command_list]
  defp decode(_, _, _, command_list), do: command_list
end
