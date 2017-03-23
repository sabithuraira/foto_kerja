defmodule FotoKerja.KegiatanControllerTest do
  use FotoKerja.ConnCase

  alias FotoKerja.Kegiatan
  @valid_attrs %{name: "some content", tahun: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, kegiatan_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing kegiatan"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, kegiatan_path(conn, :new)
    assert html_response(conn, 200) =~ "New kegiatan"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, kegiatan_path(conn, :create), kegiatan: @valid_attrs
    assert redirected_to(conn) == kegiatan_path(conn, :index)
    assert Repo.get_by(Kegiatan, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, kegiatan_path(conn, :create), kegiatan: @invalid_attrs
    assert html_response(conn, 200) =~ "New kegiatan"
  end

  test "shows chosen resource", %{conn: conn} do
    kegiatan = Repo.insert! %Kegiatan{}
    conn = get conn, kegiatan_path(conn, :show, kegiatan)
    assert html_response(conn, 200) =~ "Show kegiatan"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, kegiatan_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    kegiatan = Repo.insert! %Kegiatan{}
    conn = get conn, kegiatan_path(conn, :edit, kegiatan)
    assert html_response(conn, 200) =~ "Edit kegiatan"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    kegiatan = Repo.insert! %Kegiatan{}
    conn = put conn, kegiatan_path(conn, :update, kegiatan), kegiatan: @valid_attrs
    assert redirected_to(conn) == kegiatan_path(conn, :show, kegiatan)
    assert Repo.get_by(Kegiatan, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    kegiatan = Repo.insert! %Kegiatan{}
    conn = put conn, kegiatan_path(conn, :update, kegiatan), kegiatan: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit kegiatan"
  end

  test "deletes chosen resource", %{conn: conn} do
    kegiatan = Repo.insert! %Kegiatan{}
    conn = delete conn, kegiatan_path(conn, :delete, kegiatan)
    assert redirected_to(conn) == kegiatan_path(conn, :index)
    refute Repo.get(Kegiatan, kegiatan.id)
  end
end
