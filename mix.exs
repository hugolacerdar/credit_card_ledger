defmodule CreditCardLedger.MixProject do
  use Mix.Project

  def project do
    [
      app: :credit_card_ledger,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {CreditCardLedger.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:credo, "~> 1.4"},
      {:plug_cowboy, "~> 2.2"},
      {:ecto_sql, "~> 3.4"},
      {:jason, "~> 1.2"},
      {:myxql, "~> 0.4.1"},
    ]
  end

  defp aliases do
    [
      lint: "credo --strict",
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
