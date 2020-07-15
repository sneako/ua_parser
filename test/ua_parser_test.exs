defmodule UAParserTest do
  use ExUnit.Case
  doctest UAParser

  @user_agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0"

  test "parse user_agent using default patterns" do
    assert "mac os x" == UAParser.parse(@user_agent)
  end

  test "parse user_agent using custom patterns" do
    custom_patterns = {
      [],
      [
        %{
          regex: ~r/(Skyfire)\/(\d+)\.(\d+)(?:\.(\d+))?/,
          os_replacement: "Testing Pattern $1"
        }
      ],
      []
    }

    result = UAParser.parse(@user_agent, custom_patterns)
    assert result == "testing pattern skyfire"
  end
end
