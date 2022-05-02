defmodule Chatgud.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chatgud.Accounts.User
  alias Chatgud.Posts.Comment

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :karma, :integer, default: 0
    field :body, :string
    field :title, :string
    field :url, :string
    belongs_to :author, User
    has_many :comments, Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :title, :url, :author_id])
    |> validate_required([:body, :title, :karma, :author_id])
  end

  def data() do
    Dataloader.Ecto.new(Chatgud.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
