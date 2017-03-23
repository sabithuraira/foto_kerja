defmodule FotoKerja.Repo.Migrations.CreateKegiatan do
  use Ecto.Migration

  def change do
    create table(:kegiatan) do
      add :name, :string
      add :tahun, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:kegiatan, [:user_id])

  end
end
