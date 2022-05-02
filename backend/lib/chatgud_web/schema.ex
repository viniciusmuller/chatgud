defmodule ChatgudWeb.Schema do
  @moduledoc """
  Defines GraphQL root schemas.
  """

  use Absinthe.Schema

  alias Chatgud.Accounts.User
  alias Chatgud.Posts.{Post, Comment}

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(User, User.data())
      |> Dataloader.add_source(Comment, Comment.data())
      |> Dataloader.add_source(Post, Post.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  import_types(Absinthe.Type.Custom)
  import_types(ChatgudWeb.Schema.PostsTypes)
  import_types(ChatgudWeb.Schema.AccountTypes)
  import_types(ChatgudWeb.Schema.AuthTypes)

  query do
    import_fields(:account_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:post_mutations)
    import_fields(:comment_mutations)
  end
end
