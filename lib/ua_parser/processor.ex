defmodule UAParser.Processor do
  @moduledoc """
  Prepare a raw YAML document for consumption by the parser by
  converting charlists into strings and compiling our patterns.
  """

  @doc """
  Process a document into Elixir keyword lists and compiled patterns
  """
  def process(document) do
    document
    |> extract
    |> convert
    |> compile
  end

  defp atom_key(key) do
    key
    |> String.Chars.to_string()
    |> String.to_atom()
  end

  defp compile(groups) do
    # result: {user_agents, os, devices}
    groups
    |> Enum.map(&compile_groups/1)
    |> to_tuple
  end

  defp compile_group(group) do
    pattern =
      group
      |> Map.fetch!(:regex)
      |> Regex.compile!()

    Map.put(group, :regex, pattern)
  end

  defp compile_groups(groups), do: Enum.map(groups, &compile_group/1)

  defp convert([]), do: []

  defp convert([head | tail]) do
    result = Enum.map(head, fn x -> x |> to_keyword() |> Map.new() end)
    [result | convert(tail)]
  end

  defp extract([document | _]) do
    [_, {'os_parsers', os}, _] = document

    [[], os, []]
  end

  defp to_keyword([]), do: []

  defp to_keyword([{key, value} | tails]) do
    keyword = {atom_key(key), String.Chars.to_string(value)}
    [keyword | to_keyword(tails)]
  end

  defp to_tuple(values, tuple \\ {})
  defp to_tuple([], tuple), do: tuple

  defp to_tuple([head | tail], tuple) do
    tuple = Tuple.append(tuple, head)
    to_tuple(tail, tuple)
  end
end
