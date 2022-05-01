defmodule ChatgudWeb.PostsResolver do
  alias Chatgud.Posts

  def all_links(_root, _args, _info) do
    {:ok, Posts.list_links()}
  end

  def create_link(_root, args, _info) do
    case Posts.create_link(args) do
      {:ok, link} -> {:ok, link}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_link(_root, args, _info) do
    with {:ok, link} <- Posts.fetch_link(args.id),
         {:ok, link} <- Posts.delete_link(link) do
      {:ok, link}
    else
      {:error, msg} -> {:error, "could not delete link: #{msg}"}
    end
  end

  def update_link(_root, args, _info) do
    with {:ok, link} <- Posts.fetch_link(args.id),
         {:ok, updated_link} <- Posts.update_link(link, args) do
      {:ok, updated_link}
    else
      {:error, msg} -> {:error, "could not update link: #{msg}"}
    end
  end
end
