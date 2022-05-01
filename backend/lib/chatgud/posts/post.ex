defmodule Chatgud.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatgud.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :karma, :integer, default: 0
    field :body, :string
    field :title, :string
    field :url, :string
    belongs_to :author, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :title, :url, :author_id])
    |> validate_required([:body, :title, :karma, :author_id])
  end
end
