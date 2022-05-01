defmodule ChatgudWeb.UsersResolver do
  alias Chatgud.Accounts

  def create_user(_root, args, _info) do
    case Accounts.create_user(args) do
      {:ok, user} -> {:ok, user}
      err -> err
    end
  end

  def delete_user(_root, _args, %{context: %{current_user_id: user_id}}) do
    with {:ok, user} <- Accounts.fetch_user_by(id: user_id),
         {:ok, user} <- Accounts.delete_user(user) do
      {:ok, user}
    else
      {:error, msg} -> {:error, "could not delete user: #{msg}"}
    end
  end

  def delete_user(_, _, _), do: {:error, "current user not found"}

  def update_user(_root, args, %{context: %{current_user_id: user_id}}) do
    with {:ok, user} <- Accounts.fetch_user_by(id: user_id),
         {:ok, updated_user} <- Accounts.update_user(user, args) do
      {:ok, updated_user}
    else
      err -> err
    end
  end

  def update_user(_, _, _), do: {:error, "current user not found"}

  def login_user(_root, args, _info) do
    with {:ok, user} <- Accounts.fetch_user_by(email: args.email),
         {:ok, token} <- Accounts.login_user(user, args.password) do
      {:ok, %{token: token, user_id: user.id}}
    else
      {:error, _msg} -> {:error, "authentication error"}
    end
  end

  def get_user(_root, args, _info) do
    case Accounts.fetch_user_by(username: args.username) do
      {:error, _msg} -> {:error, "user not found"}
      success -> success
    end
  end

  def get_profile(_root, _args, %{context: %{current_user_id: user_id}}) do
    # Accounts.fetch_user_by(id: user_id) do
    case Chatgud.Repo.fetch_by(Chatgud.Accounts.User, [id: user_id], []) do
      {:error, _msg} -> {:error, "user not found"}
      success -> success
    end
  end

  def get_profile(_, _, _), do: {:error, "current user not found"}
end
