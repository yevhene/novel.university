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
  url: [host: "localhost"],
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

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Novel.Accounts.User,
  repo: Novel.Repo,
  module: Novel,
  web_module: NovelWeb,
  router: NovelWeb.Router,
  messages_backend: NovelWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Novel University",
  email_from_email: "hello@novel.university",
  opts: [
    :authenticatable,
    :recoverable,
    :lockable,
    :trackable,
    :unlockable_with_token,
    :invitable,
    :registerable
  ]

config :coherence, NovelWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
