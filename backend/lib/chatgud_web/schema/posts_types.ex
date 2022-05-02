defmodule ChatgudWeb.Schema.PostsTypes do
  @moduledoc """
  GraphQL types for posts-related queries.
  """

  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 3, dataloader: 1]

  import ChatgudWeb.Helpers.HelperMacros

  alias ChatgudWeb.Middlewares
  alias ChatgudWeb.PostsResolver
  alias Chatgud.Accounts.User
  alias Chatgud.Posts.{Post, Comment}

  object :post do
    field :id, non_null(:id)
    field :body, :string
    field :url, :string
    field :title, non_null(:string)
    field :karma, non_null(:integer)
    field :author, non_null(:user_public), resolve: dataloader(User)

    field :comments, non_null(list_of(non_null(:comment))) do
      arg(:max_depth, :integer)
      resolve(dataloader(Comment, :comments, args: %{max_depth: 5}))
    end

    creation_date()
    update_date()
  end

  object :comment do
    field :id, non_null(:id)
    field :body, non_null(:string)
    field :karma, non_null(:integer)
    field :depth, non_null(:integer)
    field :post, :post, resolve: dataloader(Post)
    field :author, non_null(:user_public), resolve: dataloader(User)
    field :parent, :comment, resolve: dataloader(Comment)
    creation_date()
    update_date()
  end

  object :post_queries do
    @desc "Get last N posts"
    field :last_n_posts, non_null(list_of(non_null(:post))) do
      arg(:n, non_null(:integer))
      resolve(&PostsResolver.last_n_posts/3)
    end
  end

  object :post_mutations do
    @desc "Create a new post"
    field :create_post, :post do
      arg(:title, non_null(:string))
      arg(:url, :string)
      arg(:body, :string)

      middleware(Middlewares.RequireAuthentication)
      resolve(&PostsResolver.create_post/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    @desc "Delete a post"
    field :delete_post, :post do
      arg(:id, non_null(:id))

      middleware(Middlewares.RequireAuthentication)
      middleware(Middlewares.RequireResourceOwnership, owner_field: :author_id)
      resolve(&PostsResolver.delete_post/3)
    end

    @desc "Update a post"
    field :edit_post, :post do
      arg(:id, non_null(:id))
      arg(:url, :string)
      arg(:title, :string)
      arg(:body, :string)

      middleware(Middlewares.RequireAuthentication)
      middleware(Middlewares.RequireResourceOwnership, owner_field: :author_id)
      resolve(&PostsResolver.update_post/3)
      middleware(Middlewares.HandleChangesetErrors)
    end
  end

  object :comment_mutations do
    @desc "Create comment"
    field :create_comment, :comment do
      arg(:body, non_null(:string))
      arg(:post_id, non_null(:id))
      arg(:parent_id, :id)

      middleware(Middlewares.RequireAuthentication)
      resolve(&PostsResolver.create_comment/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    @desc "Edit comment"
    field :edit_comment, :comment do
      arg(:id, non_null(:id))
      arg(:body, non_null(:string))

      middleware(Middlewares.RequireAuthentication)
      middleware(Middlewares.RequireResourceOwnership, owner_field: :author_id)
      resolve(&PostsResolver.update_comment/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    @desc "Delete comment"
    field :delete_comment, :comment do
      arg(:id, non_null(:id))

      middleware(Middlewares.RequireAuthentication)
      middleware(Middlewares.RequireResourceOwnership, owner_field: :author_id)
      resolve(&PostsResolver.delete_comment/3)
    end
  end
end
