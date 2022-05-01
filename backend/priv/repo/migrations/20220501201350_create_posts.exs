defmodule Chatgud.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :title, :string
      add :url, :string
      add :karma, :integer

      timestamps()
    end
  end
end
