defmodule ChatgudWeb.Schema.PostsTypes do
  use Absinthe.Schema.Notation

  alias ChatgudWeb.Middlewares
  alias ChatgudWeb.PostsResolver

  object :post do
    field :id, non_null(:id)
    field :body, :string
    field :title, non_null(:string)
    field :url, :string

    field :creation_date, :naive_datetime do
      resolve(fn parent, _, _ ->
        # Rename field
        {:ok, parent.inserted_at}
      end)
    end
  end

  # object :comment do
  #   field :id, non_null(:id)
  #   field :body, non_null(:string)
  #   field :author, non_null(:user)
  #   field :children, :comment, resolve: assoc(:comment)
  #   field :karma, non_null(:int)
  #   field :post, :post, resolve: assoc(:post)
  # end

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

      # TODO: RequireAuthorization middleware
      middleware(Middlewares.RequireAuthentication)
      resolve(&PostsResolver.create_post/3)
      middleware(Middlewares.HandleChangesetErrors)
    end

    @desc "Delete a post"
    field :delete_post, :post do
      arg(:id, non_null(:id))

      # TODO: Require user to be resource owner middleware
      middleware(Middlewares.RequireAuthentication)
      resolve(&PostsResolver.delete_post/3)
    end

    @desc "Update a post"
    field :update_post, :post do
      arg(:id, non_null(:id))
      arg(:url, :string)
      arg(:description, :string)

      # TODO: Require user to be resource owner middleware
      middleware(Middlewares.RequireAuthentication)
      resolve(&PostsResolver.update_post/3)
    end
  end

  object :comment_queries do
  end

  object :comment_mutations do
  end
end
