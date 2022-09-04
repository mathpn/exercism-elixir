defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    acc = case ast do
      {:def, _, definition} ->
        [get_trimmed_fn_name(definition) | acc]
      {:defp, _, definition} ->
        [get_trimmed_fn_name(definition) | acc]
      _ -> acc
    end
    {ast, acc}
  end

  defp get_trimmed_fn_name(definition) do
    case definition do
      [{:when, _, fn_def} | _] -> get_trimmed_fn_name(fn_def)
      [{_, _, nil} | _] -> ""
      [{fn_name, _, args} | _] -> to_string(fn_name) |> String.slice(0, length(args))
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> Enum.join()
  end
end
