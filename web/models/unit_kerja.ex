defmodule FotoKerja.UnitKerja do
  use FotoKerja.Web, :model
  
  @derive {Poison.Encoder, only: [:id, :name, :user_id]}
  schema "unit_kerja" do
    field :name, :string
    belongs_to :user, FotoKerja.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
