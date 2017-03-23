defmodule FotoKerja.KomentarTest do
  use FotoKerja.ModelCase

  alias FotoKerja.Komentar

  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Komentar.changeset(%Komentar{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Komentar.changeset(%Komentar{}, @invalid_attrs)
    refute changeset.valid?
  end
end
