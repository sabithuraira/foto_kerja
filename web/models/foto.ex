defmodule FotoKerja.Foto do
  use FotoKerja.Web, :model

  schema "foto" do
    field :file_name, :string
    field :description, :string
    belongs_to :unit_kerja, FotoKerja.UnitKerja
    belongs_to :kegiatan, FotoKerja.Kegiatan
    belongs_to :user, FotoKerja.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description,:unit_kerja_id,:kegiatan_id])
    #|> cast_attachments(params, [:file_name])
    |> validate_required([:description,:unit_kerja_id,:kegiatan_id])
  end
end
