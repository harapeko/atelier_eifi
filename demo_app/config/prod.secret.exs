use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or you later on).
config :demo_app, DemoApp.Endpoint,
  secret_key_base: "fVo/uAwLQfv8WGbk5j6MAah7QD4A1KEcMLCcB2N+xZKC0kVioWDaGeCjyRJCB4lU"

# Configure your database
config :demo_app, DemoApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "demo_app_prod",
  pool_size: 20
