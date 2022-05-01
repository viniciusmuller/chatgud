defmodule ChatgudWeb.Plugs.AuthContext do
  @moduledoc false

  @behaviour Plug

  import Plug.Conn

  alias Chatgud.Security

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  @doc """
  Return the current resource context based on the authorization header
  """
  def build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user_id} <- authorize(token) do
      %{current_user_id: user_id}
    else
      _ -> %{}
    end
  end

  defp authorize(token) do
    case Security.verify_user_token(token) do
      {:ok, user_id} -> {:ok, user_id}
      _ -> {:error, "invalid token"}
    end
  end
end
