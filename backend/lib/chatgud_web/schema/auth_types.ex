defmodule ChatgudWeb.Schema.AuthTypes do
  use Absinthe.Schema.Notation

  object :auth_payload do
    field :token, non_null(:string)
    field :user_id, non_null(:id)
  end
end
