# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :attendance_system,
  ecto_repos: [AttendanceSystem.Repo]

# Configures the endpoint
config :attendance_system, AttendanceSystem.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EJKQY/EItSHZZ+2LznIl7pdp5OUgWGwt34GpaUuyrjv64ZZm/KCvrLfcAyNpb1Aq",
  render_errors: [view: AttendanceSystem.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AttendanceSystem.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
issuer: "AttendanceSystem",
ttl: { 30, :days },
allowed_drift: 2000,
secret_key: "f4eN2vgVWqZQD24gSgrre80L1kwZlp+NHP1toPrVavSKfUB+zNYz541TwvlVZyIH",
serializer: AttendanceSystem.GuardianSerializer
