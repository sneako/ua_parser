defmodule UAParser.Parser do
  @moduledoc """
  Handle parsing the user-agent string.
  """

  alias UAParser.Parsers.OperatingSystem

  @doc """
  Parse a user-agent string given a set of patterns
  """
  def parse({_ua_patterns, os_patterns, _device_patterns}, user_agent) do
    user_agent
    |> sanitize
    |> parse_os(os_patterns)
  end

  defp parse_os(user_agent, patterns) do
    patterns
    |> search(user_agent)
    |> OperatingSystem.parse()
    |> String.downcase()
  end

  defp sanitize(user_agent), do: String.trim(user_agent)

  defp search([], _string), do: nil

  defp search([%{regex: regex} = group | groups], string) do
    case Regex.run(regex, string) do
      nil -> search(groups, string)
      match -> {group, match}
    end
  end
end
