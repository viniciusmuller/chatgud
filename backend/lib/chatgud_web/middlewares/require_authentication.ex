defmodule ChatgudWeb.Middlewares.RequireAuthentication do
  @moduledoc """
  Absinthe middleware that ensures that the current user is providing a valid 
  authentication token.
  """

  @behaviour Absinthe.Middleware
  alias Chatgud.Accounts

  def call(resolution, _config) do
    with %{current_user_id: user_id} <- resolution.context,
         {:ok, user} <- Accounts.fetch_user_by(id: user_id) do
      Map.update!(resolution, :context, &Map.put(&1, :current_user, user))
    else
      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end
end
