defmodule FotoKerja.Repo.Migrations.CreateSuka do
  use Ecto.Migration

  def change do
    create table(:suka) do
      add :is_suka, :integer
      add :foto_id, references(:foto, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:suka, [:foto_id])
    create index(:suka, [:user_id])

  end
end
