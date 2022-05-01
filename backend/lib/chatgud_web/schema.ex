defmodule ChatgudWeb.Schema do
  use Absinthe.Schema

  alias ChatgudWeb.PostsResolver
  alias ChatgudWeb.UsersResolver
  alias ChatgudWeb.Middlewares

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

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  object :auth_payload do
    field :token, non_null(:string)
    field :user_id, non_null(:id)
  end

  # object :post do
  #   field :id, non_null(:id)
  #   field :link, non_null(:link)
  #   field :author, non_null(:user)
  #   field :body, :string
  #   field :comments, non_null(list_of(non_null(:comment)))
  # end

  # object :comment do
  #   field :id, non_null(:id)
  #   field :body, non_null(:string)
  #   field :author, non_null(:user)
  #   field :children, :comment, resolve: assoc(:comment)
  #   field :karma, non_null(:int)
  #   field :post, :post, resolve: assoc(:post)
  # end

  query do
    @desc "Get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&PostsResolver.all_links/3)
    end

    @desc "Get user"
    field :get_user, :user_public do
      arg(:username, non_null(:string))

      resolve(&UsersResolver.get_user/3)
    end

    @desc "Get profile info"
    field :get_profile, :user_private do
      middleware(Middlewares.RequireAuthentication)
      resolve(&UsersResolver.get_profile/3)
    end
  end

  mutation do
    # ---------------- Unauthenticated routes ----------------
    @desc "Create a new link"
    field :create_link, :link do
      arg(:url, non_null(:string))
      arg(:description, non_null(:string))

      resolve(&PostsResolver.create_link/3)
    end

    @desc "Delete a link"
    field :delete_link, :link do
      arg(:id, non_null(:id))

      resolve(&PostsResolver.delete_link/3)
    end

    @desc "Update a link"
    field :update_link, :link do
      arg(:id, non_null(:id))
      arg(:url, :string)
      arg(:description, :string)

      resolve(&PostsResolver.update_link/3)
    end

    @desc "Login an user"
    field :login, :auth_payload do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UsersResolver.login_user/3)
    end

    @desc "Register a new user"
    field :register, :user_private do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UsersResolver.create_user/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    # ---------------- Authenticated routes ----------------
    @desc "Delete user account"
    field :delete_account, :user_private do
      middleware(Middlewares.RequireAuthentication)
      resolve(&UsersResolver.delete_user/3)
    end

    @desc "Edit user profile info"
    field :edit_profile, :user_private do
      arg(:username, :string)
      arg(:email, :string)
      arg(:password, :string)

      middleware(Middlewares.RequireAuthentication)
      resolve(&UsersResolver.update_user/3)
      middleware(Middlewares.HandleChangesetErrors)
    end
  end

  # subscription do
  #   field :new_post, :post do

  #   end

  #   field :new_comment, :comment do

  #   end
  # end
end
