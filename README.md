# OsDetect

A simple, fast user-agent parsing library based on BrowserScope's UA database with a good default dictionary.

This is a fork of beam-community/ua_parser, stripped down to only return the operating system family. It is much faster.

## Installation

Add `ua_parser` to your `mix.exs` dependencies:

```elixir
def deps do
  [{:ua_parser, github: "sneako/ua_parser", branch: "os-family-only"}]
end
```

## Usage

```elixir
iex> ua = OsDetect.parse("Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_7; en-us) AppleWebKit/530.17 (KHTML, like Gecko) Version/4.0 Safari/530.17 Skyfire/2.0")
"macos"
```
