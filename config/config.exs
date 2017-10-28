# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :novel,
  ecto_repos: [Novel.Repo]

# Configures the endpoint
config :novel, NovelWeb.Endpoint,
  url: [host: "0.0.0.0"],
  secret_key_base: "c7aes2Bqu7vvUIv42hOg1Xd2KY97FFWvd5QIhRCpZvN+ka1yKb38mTlptf5yP19y",
  render_errors: [view: NovelWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Novel.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [
      default_scope: "user:email,repo"
    ]}
  ]

config :novel, NovelWeb.Guardian,
  issuer: "Novel.#{Mix.env}",
  secret_key: "gkQiIFPZf8zf20ZO0+gw0ugozfqWMIZQXJD6/Q0chGVaOSvBXRC9EgLp7S2P62fn"

config :novel, NovelWeb.Gettext, default_locale: "uk"
