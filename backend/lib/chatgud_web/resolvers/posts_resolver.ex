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
      err -> err
    end
  end

  def create_comment(_root, args, %{context: %{current_user: user}}) do
    depth =
      with {:ok, parent_id} <- Map.fetch(args, :parent_id),
           {:ok, comment} <- Posts.fetch_comment_by(id: parent_id) do
        comment.depth + 1
      else
        _ -> 0
      end

    data = Map.merge(args, %{author_id: user.id, depth: depth})

    case Posts.create_comment(data) do
      {:ok, comment} -> {:ok, comment}
      err -> err
    end
  end

  def update_comment(_root, args, %{context: %{current_user: _user}}) do
    with {:ok, comment} <- Posts.fetch_comment_by(id: args.id),
         {:ok, updated_comment} <- Posts.update_comment(comment, args) do
      {:ok, updated_comment}
    else
      err -> err
    end
  end

  def delete_comment(_root, args, %{context: %{current_user: _user}}) do
    with {:ok, comment} <- Posts.fetch_comment_by(id: args.id),
         {:ok, comment} <- Posts.delete_comment(comment) do
      {:ok, comment}
    else
      {:error, msg} -> {:error, "could not delete comment: #{msg}"}
    end
  end
end
