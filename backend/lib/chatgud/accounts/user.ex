defmodule Chatgud.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatgud.Security
  alias Chatgud.Posts.{Post, Comment}

  @fields ~w(username password email)a

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :posts, Post, foreign_key: :author_id
    has_many :comments, Comment, foreign_key: :author_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Security.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset

  def data() do
    Dataloader.Ecto.new(Chatgud.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
