defmodule Chatgud.Repo do
  use Ecto.Repo,
    otp_app: :chatgud,
    adapter: Ecto.Adapters.Postgres

  def fetch(query) do
    case all(query) do
      [] -> {:error, query}
      [obj] -> {:ok, obj}
      _ -> raise "Expected one or no items, got many items #{inspect(query)}"
    end
  end
end
