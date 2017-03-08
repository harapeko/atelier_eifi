# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :demo_app,
  ecto_repos: [DemoApp.Repo]

# Configures the endpoint
config :demo_app, DemoApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "h3eYbVc2aMlqVZD/xd7msGPe7njn2zx6jzZigIsDiCpQaQQUlt6V7ze5FSFXAPQc",
  render_errors: [view: DemoApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DemoApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
