defmodule Chatgud.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chatgud.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        password_hash: "some password_hash",
        username: "some username"
      })
      |> Chatgud.Accounts.create_user()

    user
  end
end
