defmodule Playground.Repo do
  use Ecto.Repo,
    otp_app: :playground,
    adapter: Ecto.Adapters.SQLite3
end
