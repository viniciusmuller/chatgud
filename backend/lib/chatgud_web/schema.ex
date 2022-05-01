defmodule ChatgudWeb.Schema do
  use Absinthe.Schema

  alias ChatgudWeb.PostsResolver
  alias ChatgudWeb.UsersResolver

  object :user do
    field :id, non_null(:id)
    field :username, non_null(:string)
    # field :posts, non_null(list_of(:post))
    # field :comments, non_null(list_of(:comments))
  end

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  object :auth_payload do
    field :token, non_null(:string)
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
  #   field :parent, :comment, resolve: assoc(:comment)
  #   field :post, :post, resolve: assoc(:post)
  # end

  query do
    @desc "Get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&PostsResolver.all_links/3)
    end
  end

  mutation do
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

    @desc "Create a new user"
    field :create_user, :user do
      arg(:username, non_null(:string))
      arg(:email, :string)
      arg(:password, non_null(:string))

      resolve(handle_errors(&UsersResolver.create_user/3))
    end

    @desc "Delete an user"
    field :delete_user, :user do
      arg(:id, non_null(:id))

      resolve(&UsersResolver.delete_user/3)
    end

    @desc "Update an user"
    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:username, :string)
      arg(:email, :string)
      arg(:password, :string)

      resolve(&UsersResolver.update_user/3)
    end

    @desc "Login an user"
    field :login_user, :auth_payload do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&UsersResolver.login_user/3)
    end
  end

  # subscription do
  #   field :new_post, :post do

  #   end
  # end

  def handle_errors(fun) do
    fn source, args, info ->
      case Absinthe.Resolution.call(fun, source, args, info) do
        {:error, %Ecto.Changeset{} = changeset} -> {:error, format_changeset(changeset)}
        val -> val
      end
    end
  end

  def format_changeset(%Ecto.Changeset{} = changeset) do
    errors =
      Enum.map(changeset.errors, fn {field, detail} ->
        %{
          source: field,
          detail: render_detail(detail)
        }
      end)

    %{details: errors, message: "Validation error"}
  end

  def render_detail({message, values}) do
    Enum.reduce(values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end)
  end

  def render_detail(message) do
    message
  end
end
