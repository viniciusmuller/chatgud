defmodule ChatgudWeb.UsersResolver do
  alias Chatgud.Accounts

  def create_user(_root, args, _info) do
    case Accounts.create_user(args) do
      {:ok, link} -> {:ok, link}
      {:error, changeset} -> {:error, changeset} # TODO: Properly format ECTO errors
    end
  end

  def delete_user(_root, args, _info) do
    with {:ok, link} <- Accounts.fetch_user(args.id),
         {:ok, link} <- Accounts.delete_user(link) do
      {:ok, link}
    else
      {:error, msg} -> {:error, "could not delete user: #{msg}"}
    end
  end

  def update_user(_root, args, _info) do
    with {:ok, link} <- Accounts.fetch_user(args.id),
         {:ok, updated_link} <- Accounts.update_user(link, args) do
      {:ok, updated_link}
    else
      {:error, msg} -> {:error, "could not update user: #{msg}"}
    end
  end
end
