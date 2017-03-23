defmodule FotoKerja.UnitKerjaControllerTest do
  use FotoKerja.ConnCase

  alias FotoKerja.UnitKerja
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, unit_kerja_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing unit kerja"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, unit_kerja_path(conn, :new)
    assert html_response(conn, 200) =~ "New unit kerja"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, unit_kerja_path(conn, :create), unit_kerja: @valid_attrs
    assert redirected_to(conn) == unit_kerja_path(conn, :index)
    assert Repo.get_by(UnitKerja, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, unit_kerja_path(conn, :create), unit_kerja: @invalid_attrs
    assert html_response(conn, 200) =~ "New unit kerja"
  end

  test "shows chosen resource", %{conn: conn} do
    unit_kerja = Repo.insert! %UnitKerja{}
    conn = get conn, unit_kerja_path(conn, :show, unit_kerja)
    assert html_response(conn, 200) =~ "Show unit kerja"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, unit_kerja_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    unit_kerja = Repo.insert! %UnitKerja{}
    conn = get conn, unit_kerja_path(conn, :edit, unit_kerja)
    assert html_response(conn, 200) =~ "Edit unit kerja"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    unit_kerja = Repo.insert! %UnitKerja{}
    conn = put conn, unit_kerja_path(conn, :update, unit_kerja), unit_kerja: @valid_attrs
    assert redirected_to(conn) == unit_kerja_path(conn, :show, unit_kerja)
    assert Repo.get_by(UnitKerja, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    unit_kerja = Repo.insert! %UnitKerja{}
    conn = put conn, unit_kerja_path(conn, :update, unit_kerja), unit_kerja: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit unit kerja"
  end

  test "deletes chosen resource", %{conn: conn} do
    unit_kerja = Repo.insert! %UnitKerja{}
    conn = delete conn, unit_kerja_path(conn, :delete, unit_kerja)
    assert redirected_to(conn) == unit_kerja_path(conn, :index)
    refute Repo.get(UnitKerja, unit_kerja.id)
  end
end
