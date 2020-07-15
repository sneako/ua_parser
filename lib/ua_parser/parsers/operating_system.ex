defmodule UAParser.Parsers.OperatingSystem do
  @moduledoc """
  A parser module representing the operating system derived
  from a user agent.
  """
  def parse(nil), do: nil

  def parse({%{os_replacement: replacement}, match}) when is_binary(replacement) do
    replace(replacement, 1, match)
  end

  def parse({_, [_, match | _]}), do: match

  def replace(string, position, match) do
    val = Enum.at(match, position)

    if val do
      String.replace(string, "$#{position}", val)
    else
      string
    end
  end
end
