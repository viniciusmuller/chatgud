defmodule Chatgud.Repo.Migrations.CommentAssociations do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :author_id, references(:users)
      add :post_id, references(:posts)
      add :parent_id, references(:comments)
    end
  end
end
