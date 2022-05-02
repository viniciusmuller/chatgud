defmodule ChatgudWeb.Schema.AuthTypes do
  @moduledoc """
  GraphQL types for authentication-related queries.
  """

  use Absinthe.Schema.Notation

  object :auth_payload do
    field :token, non_null(:string)
    field :user_id, non_null(:id)
  end
end
