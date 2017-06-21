# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :foto_kerja,
  ecto_repos: [FotoKerja.Repo]

# Configures the endpoint
config :foto_kerja, FotoKerja.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "50N9PogeC12KThZWAaJqcxsdz9q8YLktWjiX2NddmOtXj/qYgvlsU+9cYjofsA6E",
  render_errors: [view: FotoKerja.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FotoKerja.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :guardian, Guardian,
    #allowed_algos: ["HS512"], # optional
    #verify_module: Guardian.JWT,  # optional
    issuer: "FotoKerja",
    ttl: { 30, :days },
    #allowed_drift: 2000,
    verify_issuer: true, # optional
    secret_key: to_string(Mix.env)<>"h1IMpr*gr4mm3r",
    serializer: FotoKerja.GuardianSerializer

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []},
    facebook: { Ueberauth.Strategy.Facebook, [default_scope: "email,public_profile,user_friends"]}
  ]

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
