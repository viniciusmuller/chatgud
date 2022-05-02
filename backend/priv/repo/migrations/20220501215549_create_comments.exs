defmodule Chatgud.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :body, :string
      add :karma, :integer
      add :depth, :integer

      timestamps()
    end
  end
end
