defmodule Yugo.Leex do
  def parse(input) when is_list(input) do
    acc = parse_tokens(input, [])

    Enum.reverse(acc)
  end

  def parse(input) when is_binary(input) do
    input
    |> String.to_charlist()
    |> parse()
  end

  defp parse_tokens([], acc), do: acc

  defp parse_tokens(input, acc) do
    case next_token(input) do
      {:done, {:ok, {:octet_count, _, count}, _}, rest} ->
        {body, new_rest} = take_octet_count(rest, count)

        parse_tokens(new_rest, [{:string, count, body} | acc])

      {:done, {:ok, token, _}, rest} ->
        parse_tokens(rest, [token | acc])
    end
  end

  defp next_token(input) do
    :imap_lexer.token([], input)
  end

  defp take_octet_count(rest, count) do
    IO.inspect({rest, count})

    rest
    |> drop_whitespaces()
    |> tap(fn [a | _] ->
      IO.inspect(a)
    end)
    |> Enum.split(count)
  end

  defp drop_whitespaces([char | rest]) when char in [?\s, ?\n, ?\t],
    do: drop_whitespaces(rest)

  defp drop_whitespaces(rest), do: rest
end
