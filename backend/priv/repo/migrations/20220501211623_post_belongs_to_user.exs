defmodule Chatgud.Repo.Migrations.PostBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :author_id, references(:users)
    end
  end
end
