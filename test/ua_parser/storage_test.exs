defmodule UAParser.StorageTest do
  use ExUnit.Case

  test "lists storage contents" do
    assert [%{regex: regex} | _] = UAParser.Storage.list()
    assert Regex.regex?(regex)
  end
end
