defmodule ChatgudWeb.Schema do
  use Absinthe.Schema

  alias ChatgudWeb.PostsResolver

  # object :user do
  #   field :id, non_null(:id)
  #   field :username, non_null(:link)
  #   field :posts, non_null(list_of(:post))
  #   field :comments, non_null(list_of(:comments))
  # end

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
  #   field :parent, :comment, resolve: assoc(:comment)
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
  end

  # subscription do
  #   field :new_post, :post do

  #   end
  # end
end
