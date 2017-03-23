defmodule FotoKerja.Repo.Migrations.CreateKomentar do
  use Ecto.Migration

  def change do
    create table(:komentar) do
      add :description, :text
      add :foto_id, references(:foto, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:komentar, [:foto_id])
    create index(:komentar, [:user_id])

  end
end
