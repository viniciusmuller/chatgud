defmodule ChatgudWeb.Schema.AccountTypes do
  use Absinthe.Schema.Notation

  alias ChatgudWeb.Middlewares
  alias ChatgudWeb.AccountsResolver

  object :user_public do
    field :id, non_null(:id)
    field :username, non_null(:string)
    # field :posts, non_null(list_of(:post))
    # field :comments, non_null(list_of(:comments))
  end

  object :user_private do
    import_fields(:user_public)
    field :email, non_null(:string)
  end

  object :account_queries do
    @desc "Get user"
    field :get_user, :user_public do
      arg(:username, non_null(:string))

      resolve(&AccountsResolver.get_user/3)
    end

    @desc "Get profile info"
    field :get_profile, :user_private do
      middleware(Middlewares.RequireAuthentication)
      resolve(&AccountsResolver.get_profile/3)
    end
  end

  object :account_mutations do
    @desc "Login an user"
    field :login, :auth_payload do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&AccountsResolver.login_user/3)
    end

    @desc "Register a new user"
    field :register, :user_private do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&AccountsResolver.create_user/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    # ---------------- Authenticated routes ----------------
    @desc "Delete user account"
    field :delete_account, :user_private do
      middleware(Middlewares.RequireAuthentication)
      resolve(&AccountsResolver.delete_user/3)
    end

    @desc "Edit user profile info"
    field :edit_profile, :user_private do
      arg(:username, :string)
      arg(:email, :string)
      arg(:password, :string)

      middleware(Middlewares.RequireAuthentication)
      resolve(&AccountsResolver.update_user/3)
      middleware(Middlewares.HandleChangesetErrors)
    end
  end
end
