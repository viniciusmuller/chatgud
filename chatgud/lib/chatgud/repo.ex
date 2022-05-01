defmodule Chatgud.Repo do
  use Ecto.Repo,
    otp_app: :chatgud,
    adapter: Ecto.Adapters.Postgres
end
