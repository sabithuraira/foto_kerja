defmodule FotoKerja.SukaTest do
  use FotoKerja.ModelCase

  alias FotoKerja.Suka

  @valid_attrs %{is_suka: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Suka.changeset(%Suka{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Suka.changeset(%Suka{}, @invalid_attrs)
    refute changeset.valid?
  end
end
