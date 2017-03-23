defmodule FotoKerja.Repo.Migrations.CreateUnitKerja do
  use Ecto.Migration

  def change do
    create table(:unit_kerja) do
      add :name, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:unit_kerja, [:user_id])

  end
end
