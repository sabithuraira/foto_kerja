defmodule FotoKerja.User do
  use FotoKerja.Web, :model

  alias FotoKerja.Repo
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :username, :string
    field :name, :string
    field :password, :string
    field :email, :string
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @required_fields ~w(username name email password password_confirmation)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required([:username, :name, :password, :password_confirmation, :email])
    |> validate_format(:email, ~r/@/, message: "Please fix your email format")
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
  end

  def generate_password_and_store_user(changeset) do
        put_change(changeset, :password, hashpwsalt(changeset.params["password"]))
          |> Repo.insert
  end
end
