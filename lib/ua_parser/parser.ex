defmodule UAParser.Parser do
  @moduledoc """
  Handle parsing the user-agent string.
  """

  @doc """
  Parse a user-agent string given a set of patterns
  """
  def parse(_os_patterns, nil), do: nil

  def parse(os_patterns, user_agent) do
    sanitized = sanitize(user_agent)

    case extract(sanitized) do
      extracted when is_binary(extracted) -> extracted
      nil -> parse_os(sanitized, os_patterns)
    end
  end

  defp parse_os(user_agent, patterns) do
    patterns
    |> search(user_agent)
    |> downcase()
    |> normalize()
  end

  defp sanitize(user_agent), do: user_agent |> String.trim()

  defp search([], _string), do: nil

  defp search([%{regex: regex} | groups], string) do
    case Regex.run(regex, string) do
      [_, match | _] -> match
      [match] -> match
      nil -> search(groups, string)
    end
  end

  defp normalize(nil), do: nil
  defp normalize("mac os x"), do: "macos"
  defp normalize("cros"), do: "chrome os"
  defp normalize("ubuntu"), do: "linux"
  defp normalize("fedora"), do: "linux"
  defp normalize("debian"), do: "linux"
  defp normalize(other), do: other

  defp downcase(str) when is_binary(str), do: String.downcase(str)
  defp downcase(other), do: other

  defp extract(<<"Android", _rest::binary()>>), do: "android"
  defp extract(<<"iPhone", _rest::binary()>>), do: "ios"
  defp extract(<<"iPad", _rest::binary()>>), do: "ios"
  defp extract(<<"iPod", _rest::binary()>>), do: "ios"
  defp extract(<<"Macintosh", _rest::binary()>>), do: "macos"
  defp extract(<<"Windows Phone", _rest::binary()>>), do: "windows phone"
  defp extract(<<"Windows Mobile", _rest::binary()>>), do: "windows phone"
  defp extract(<<"Windows NT", _rest::binary()>>), do: "windows"
  defp extract(<<_::binary-size(1), rest::binary()>>), do: extract(rest)
  defp extract(""), do: nil
end
