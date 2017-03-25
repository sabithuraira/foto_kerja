defmodule FotoKerja.Suka do
  use FotoKerja.Web, :model

  schema "suka" do
    field :is_suka, :integer
    belongs_to :foto, FotoKerja.Foto
    belongs_to :user, FotoKerja.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:is_suka, :foto_id, :user_id])
    |> validate_required([:is_suka])
  end
end
