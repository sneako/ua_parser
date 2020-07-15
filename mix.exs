defmodule OsDetect.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :os_detect,
      description: "Parse operating system from user-agent strings with BrowserScope patterns",
      version: @version,
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_aplications: [:logger, :yamerl]]
  end

  defp deps do
    [
      {:yamerl, "~> 0.7"},
      {:credo, "~> 1.0.5", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
