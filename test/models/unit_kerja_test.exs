defmodule FotoKerja.UnitKerjaTest do
  use FotoKerja.ModelCase

  alias FotoKerja.UnitKerja

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UnitKerja.changeset(%UnitKerja{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UnitKerja.changeset(%UnitKerja{}, @invalid_attrs)
    refute changeset.valid?
  end
end
