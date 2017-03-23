defmodule FotoKerja.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :name, :string
      add :password, :string
      add :email, :string

      timestamps()
    end

  end
end
