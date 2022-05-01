defmodule ChatgudWeb.Schema do
  use Absinthe.Schema

  alias Chatgud.Accounts.User

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(User, User.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  import_types(Absinthe.Type.Custom)
  import_types(ChatgudWeb.Schema.AccountTypes)
  import_types(ChatgudWeb.Schema.AuthTypes)
  import_types(ChatgudWeb.Schema.PostsTypes)

  query do
    import_fields(:account_queries)
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:account_mutations)
    import_fields(:post_mutations)
  end
end
