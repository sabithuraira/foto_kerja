defmodule FotoKerja.KegiatanTest do
  use FotoKerja.ModelCase

  alias FotoKerja.Kegiatan

  @valid_attrs %{name: "some content", tahun: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Kegiatan.changeset(%Kegiatan{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Kegiatan.changeset(%Kegiatan{}, @invalid_attrs)
    refute changeset.valid?
  end
end
