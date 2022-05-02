defmodule Chatgud.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chatgud.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        karma: 42
      })
      |> Chatgud.Posts.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, comment} =
      attrs
      |> Enum.into(%{
        body: "some body",
        karma: 42
      })
      |> Chatgud.Posts.create_comment()

    comment
  end
end
