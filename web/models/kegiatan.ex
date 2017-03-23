defmodule FotoKerja.Kegiatan do
  use FotoKerja.Web, :model

  schema "kegiatan" do
    field :name, :string
    field :tahun, :integer
    belongs_to :user, FotoKerja.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :tahun])
    |> validate_required([:name, :tahun])
  end
end
