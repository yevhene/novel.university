use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :novel, NovelWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :novel, Novel.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "novel_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :junit_formatter,
  report_file: "report_file_test.xml",
  report_dir: "tmp",
  print_report_file: true
