defmodule ChatgudWeb.NewsResolver do
  alias Chatgud.News

  def all_links(_root, _args, _info) do
    {:ok, News.list_links()}
  end

  def create_link(_root, args, _info) do
    case News.create_link(args) do
      {:ok, link} -> {:ok, link}
      {:error, errors} -> {:error, errors}
    end
  end

  def delete_link(_root, args, _info) do
    with {:ok, link} <- News.fetch_link(args.id),
         {:ok, link} <- News.delete_link(link) do
      {:ok, link}
    else
      {:error, msg} -> {:error, "could not delete link: #{msg}"}
    end
  end

  def update_link(_root, args, _info) do
    with {:ok, link} <- News.fetch_link(args.id),
         {:ok, updated_link} <- News.update_link(link, args) do
      {:ok, updated_link}
    else
      {:error, msg} -> {:error, "could not update link: #{msg}"}
    end
  end
end
