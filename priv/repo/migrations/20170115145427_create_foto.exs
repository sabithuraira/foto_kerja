defmodule FotoKerja.Repo.Migrations.CreateFoto do
  use Ecto.Migration

  def change do
    create table(:foto) do
      add :file_name, :string
      add :description, :text
      add :unit_kerja, references(:unit_kerja, on_delete: :nothing)
      add :kegiatan, references(:kegiatan, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:foto, [:unit_kerja])
    create index(:foto, [:kegiatan])
    create index(:foto, [:user_id])

  end
end
