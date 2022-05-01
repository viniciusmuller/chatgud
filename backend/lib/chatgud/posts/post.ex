defmodule Chatgud.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :karma, :integer, default: 0
    field :body, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :karma, :title, :url])
    |> validate_required([:body, :karma, :title])
  end
end
