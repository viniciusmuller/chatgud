defmodule ChatgudWeb.AccountsResolver do
  @moduledoc """
  Helper to resolve accounts-related GraphQL queries.
  """

  alias Chatgud.Accounts

  # ------------- Authenticated routes -------------
  def delete_user(_root, _args, %{context: %{current_user: user}}) do
    case Accounts.delete_user(user) do
      {:ok, user} -> {:ok, user}
      {:error, msg} -> {:error, "could not delete user: #{msg}"}
    end
  end

  def update_user(_root, args, %{context: %{current_user: user}}) do
    case Accounts.update_user(user, args) do
      {:ok, updated_user} -> {:ok, updated_user}
      err -> err
    end
  end

  def get_profile(_root, _args, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  # ------------- Unauthenticated routes -------------
  def login_user(_root, args, _info) do
    with {:ok, user} <- Accounts.fetch_user_by(email: args.email),
         {:ok, token} <- Accounts.login_user(user, args.password) do
      {:ok, %{token: token, user_id: user.id}}
    else
      {:error, _msg} -> {:error, "authentication error"}
    end
  end

  def create_user(_root, args, _info) do
    case Accounts.create_user(args) do
      {:ok, user} -> {:ok, user}
      err -> err
    end
  end

  def get_user(_root, args, _info) do
    case Accounts.fetch_user_by(username: args.username) do
      {:error, _msg} -> {:error, "user not found"}
      success -> success
    end
  end
end
