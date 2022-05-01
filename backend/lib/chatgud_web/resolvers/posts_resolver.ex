defmodule ChatgudWeb.PostsResolver do
  alias Chatgud.Posts

  def last_n_posts(_root, args, _info) do
    {:ok, Posts.last_n_posts(args.n)}
  end

  def create_post(_root, args, %{context: %{current_user: user}}) do
    data = Map.put(args, :author_id, user.id)
    case Posts.create_post(data) do
      {:ok, post} -> {:ok, post}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def delete_post(_root, args, %{context: %{current_user: _user}}) do
    with {:ok, post} <- Posts.fetch_post_by(id: args.id),
         {:ok, post} <- Posts.delete_post(post) do
      {:ok, post}
    else
      {:error, msg} -> {:error, "could not delete post: #{msg}"}
    end
  end

  def update_post(_root, args, %{context: %{current_user: _user}}) do
    with {:ok, post} <- Posts.fetch_post_by(id: args.id),
         {:ok, updated_post} <- Posts.update_post(post, args) do
      {:ok, updated_post}
    else
      {:error, msg} -> {:error, "could not update post: #{msg}"}
    end
  end
end
