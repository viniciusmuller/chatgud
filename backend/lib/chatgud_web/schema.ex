defmodule ChatgudWeb.Schema do
  use Absinthe.Schema

  alias ChatgudWeb.PostsResolver

  import_types(ChatgudWeb.Schema.AccountTypes)
  import_types(ChatgudWeb.Schema.AuthTypes)

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
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
    import_fields(:account_queries)

    @desc "Get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&PostsResolver.all_links/3)
    end
  end

  mutation do
    import_fields(:account_mutations)

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

    # subscription do
    #   field :new_post, :post do

    #   end

    #   field :new_comment, :comment do

    #   end
    # end
  end
end
