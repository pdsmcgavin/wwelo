use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :wwelo, WweloWeb.Endpoint,
  http: [
    port: 4000
  ],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/.bin/webpack-dev-server",
      "--inline",
      "--colors",
      "--hot",
      "--stdin",
      "--host",
      "0.0.0.0",
      "--port",
      "8080",
      "--public",
      "0.0.0.0:8080",
      cd: Path.expand("../assets", __DIR__)
    ]
  ]

# Watch static and templates for browser reloading.
config :wwelo, WweloWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/wwelo_web/views/.*(ex)$},
      ~r{lib/wwelo_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n", level: :info

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
# config :wwelo, Wwelo.Repo,
#   adapter: Ecto.Adapters.Postgres,
#   username: "postgres",
#   password: "postgres",
#   database: "wwelo_dev",
#   hostname: "0.0.0.0",
#   pool_size: 10

config :wwelo, Wwelo.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "wwelo",
  username: "wwelo",
  password: "wwelo",
  admin_username: "postgres",
  admin_password: "postgres",
  hostname: "db"

config :wwelo, :children, [Wwelo.Repo, WweloWeb.Endpoint]

# Pre-commit hooks
config :pre_commit,
  commands: [
    "format",
    "coveralls",
    "credo",
    "dialyzer",
    "match_elo_consts_json",
    "run_eslint",
    "run_jest"
  ],
  verbose: true
