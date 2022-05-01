defmodule Chatgud.Repo do
  use Ecto.Repo,
    otp_app: :chatgud,
    adapter: Ecto.Adapters.Postgres

  def fetch_by(queryable, clauses, opts) do
    case get_by(queryable, clauses, opts) do
      nil -> {:error, "resource not found"}
      resource -> {:ok, resource}
    end
  end
end
