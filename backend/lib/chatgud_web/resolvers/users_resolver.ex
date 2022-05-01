defmodule ChatgudWeb.UsersResolver do
  alias Chatgud.Accounts

  def create_user(_root, args, _info) do
    case Accounts.create_user(args) do
      {:ok, user} -> {:ok, user}
      err -> err
    end
  end

  def delete_user(_root, args, _info) do
    with {:ok, user} <- Accounts.fetch_user_by(id: args.id),
         {:ok, user} <- Accounts.delete_user(user) do
      {:ok, user}
    else
      {:error, msg} -> {:error, "could not delete user: #{msg}"}
    end
  end

  def update_user(_root, args, _info) do
    with {:ok, user} <- Accounts.fetch_user_by(id: args.id),
         {:ok, updated_user} <- Accounts.update_user(user, args) do
      {:ok, updated_user}
    else
      {:error, msg} -> {:error, "could not update user: #{msg}"}
    end
  end

  def login_user(_root, args, _info) do
    with {:ok, user} <- Accounts.fetch_user_by(email: args.email),
         {:ok, token} <- Accounts.login_user(user, args.password) do
      {:ok, %{token: token}}
    else
      {:error, _msg} -> {:error, "authentication error"}
    end
  end
end
