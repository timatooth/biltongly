defmodule Biltongly.Repo do
  use Ecto.Repo,
    otp_app: :biltongly,
    adapter: Ecto.Adapters.Postgres
end
