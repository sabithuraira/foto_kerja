defmodule FotoKerja.Komentar do
  use FotoKerja.Web, :model

  schema "komentar" do
    field :description, :string
    belongs_to :foto, FotoKerja.Foto
    belongs_to :user, FotoKerja.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :foto_id, :user_id])
    |> validate_required([:description])
  end
end
