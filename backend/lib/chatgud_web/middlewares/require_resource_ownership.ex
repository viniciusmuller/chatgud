defmodule ChatgudWeb.Middlewares.RequireResourceOwnership do
  @moduledoc """
  Absinthe middleware that ensures that the current user is the owner of the
  resource he is trying to operate on.
  """

  @behaviour Absinthe.Middleware

  def call(resolution, config) do
    case resolution.context do
      %{current_user_id: user_id} ->
        owner_id = Map.get(resolution.arguments, config[:owner_field])

        if owner_id != user_id do
          Absinthe.Resolution.put_result(resolution, {:error, "unauthorized"})
        end

      _ ->
        Absinthe.Resolution.put_result(resolution, {:error, "unauthenticated"})
    end
  end
end
