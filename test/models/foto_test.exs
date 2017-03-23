defmodule FotoKerja.FotoTest do
  use FotoKerja.ModelCase

  alias FotoKerja.Foto

  @valid_attrs %{description: "some content", file_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Foto.changeset(%Foto{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Foto.changeset(%Foto{}, @invalid_attrs)
    refute changeset.valid?
  end
end
