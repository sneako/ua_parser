defmodule UAParser.ProcessorTest do
  use ExUnit.Case

  alias UAParser.Processor

  test "converts yaml document into data structure" do
    result = Processor.process(test_data())

    assert is_list(result)
    assert [%{regex: pattern} | _] = result
    assert Regex.regex?(pattern)
  end

  def test_data do
    File.cwd!()
    |> Path.join("test/fixtures/patterns.yml")
    |> :yamerl_constr.file()
  end
end
