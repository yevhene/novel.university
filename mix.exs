defmodule Novel.Mixfile do
  use Mix.Project

  def project do
    [
      app: :novel,
      version: "0.4.3",
      elixir: "~> 1.6",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),

      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "coveralls": :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Novel.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.2"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.3"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.11"},
      {:gettext, "~> 0.13.1"},
      {:cowboy, "~> 1.1.2"},
      {:ueberauth_github, "~> 0.4"},
      {:guardian, "~> 1.0.1"},
      {:tentacat, "~> 0.7.1"},
      {:earmark, "~> 1.2.5"},
      {:calendar, "~> 0.17.4"},
      {:csv, "~> 2.1.1"},

      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:credo, "~> 0.9.2", only: [:dev, :test], runtime: false},
      {:junit_formatter, "~> 2.2.0", only: :test},
      {:excoveralls, "~> 0.8.2", only: :test},
      {:edeliver, "~> 1.4.6"},
      {:distillery, "~> 1.5.2", runtime: false}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "localize": ["gettext.extract", "gettext.merge priv/gettext"]
    ]
  end
end
