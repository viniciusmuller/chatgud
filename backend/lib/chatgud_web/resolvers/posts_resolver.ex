defmodule ChatgudWeb.PostsResolver do
  @moduledoc """
  Helper to resolve posts-related GraphQL queries.
  """

  alias Absinthe.Subscription
  alias Chatgud.Posts
  alias Chatgud.Posts.{Comment, Post}
  alias Chatgud.Accounts.User

  def last_n_posts(_root, args, _info) do
    {:ok, Posts.last_n_posts(args.n)}
  end

  def create_post(_root, args, %{context: %{current_user: user}}) do
    data = Map.put(args, :author_id, user.id)

    case Posts.create_post(data) do
      {:ok, post} ->
        Subscription.publish(ChatgudWeb.Endpoint, post, new_post: "*")
        {:ok, post}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def delete_post(_root, args, %{context: %{current_user: user}}) do
    with {:ok, post} <- Posts.fetch_post_by(id: args.id),
         {:ok, post} <- ensure_ownership(user, post),
         {:ok, post} <- Posts.delete_post(post) do
      {:ok, post}
    else
      {:error, msg} -> {:error, "could not delete post: #{msg}"}
    end
  end

  def update_post(_root, args, %{context: %{current_user: user}}) do
    with {:ok, post} <- Posts.fetch_post_by(id: args.id),
         {:ok, post} <- ensure_ownership(user, post),
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

  def update_comment(_root, args, %{context: %{current_user: user}}) do
    with {:ok, comment} <- Posts.fetch_comment_by(id: args.id),
         {:ok, comment} <- ensure_ownership(user, comment),
         {:ok, updated_comment} <- Posts.update_comment(comment, args) do
      {:ok, updated_comment}
    else
      err -> err
    end
  end

  def delete_comment(_root, args, %{context: %{current_user: user}}) do
    with {:ok, comment} <- Posts.fetch_comment_by(id: args.id),
         {:ok, comment} <- ensure_ownership(user, comment),
         {:ok, comment} <- Posts.delete_comment(comment) do
      {:ok, comment}
    else
      {:error, msg} -> {:error, "could not delete comment: #{msg}"}
    end
  end

  defp ensure_ownership(user = %User{}, comment = %Comment{}) do
    if user.id == comment.author_id do
      {:ok, comment}
    else
      {:error, "unauthorized"}
    end
  end

  defp ensure_ownership(user = %User{}, post = %Post{}) do
    if user.id == post.author_id do
      {:ok, post}
    else
      {:error, "unauthorized"}
    end
  end
end
