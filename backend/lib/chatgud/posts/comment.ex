defmodule Chatgud.Posts.Comment do
  @moduledoc """
  Schema that represents a comment from an user in the application.
  """

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Chatgud.Posts.{Comment, Post}
  alias Chatgud.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :body, :string
    field :karma, :integer, default: 0
    field :depth, :integer, default: 0

    belongs_to :parent, Comment
    has_many :children, Comment, foreign_key: :parent_id

    belongs_to :author, User
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :karma, :depth, :author_id, :post_id, :parent_id])
    |> validate_required([:body, :karma, :author_id, :post_id])
  end

  def data() do
    Dataloader.Ecto.new(Chatgud.Repo, query: &query/2)
  end

  def query(Comment, %{max_depth: max_depth}) do
    from c in Comment, where: c.depth <= ^max_depth
  end

  def query(Comment, _params), do: Comment
end
