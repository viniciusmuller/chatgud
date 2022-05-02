defmodule Chatgud.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Chatgud.Repo

  alias Chatgud.Accounts.User
  alias Chatgud.Security

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user.

  ## Examples

      iex> fetch_user_by(id: 23432)
      {:ok, %User{}}

      iex> fetch_user_by(email: "foo@foo.com")
      {:error, "user not found"}

  """
  def fetch_user_by(clauses, opts \\ []) do
    case Repo.fetch_by(User, clauses, opts) do
      {:ok, user} -> {:ok, user}
      {:error, _} -> {:error, "user not found"}
    end
  end

  @doc """
    Tries to login an user

  ## Examples

      iex> login_user(123)
      {:ok, %{token: "..."}}

      iex> login_user()
      {:error, "user not found"}

  """
  def login_user(user, password) do
    case Security.check_pass(user, password) do
      {:ok, user} -> {:ok, Security.sign_user_token(user.id)}
      {:error, _} -> {:error, "authentication failed"}
    end
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
