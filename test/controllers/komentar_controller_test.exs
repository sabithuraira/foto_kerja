defmodule FotoKerja.KomentarControllerTest do
  use FotoKerja.ConnCase

  alias FotoKerja.Komentar
  @valid_attrs %{description: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, komentar_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing komentar"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, komentar_path(conn, :new)
    assert html_response(conn, 200) =~ "New komentar"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, komentar_path(conn, :create), komentar: @valid_attrs
    assert redirected_to(conn) == komentar_path(conn, :index)
    assert Repo.get_by(Komentar, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, komentar_path(conn, :create), komentar: @invalid_attrs
    assert html_response(conn, 200) =~ "New komentar"
  end

  test "shows chosen resource", %{conn: conn} do
    komentar = Repo.insert! %Komentar{}
    conn = get conn, komentar_path(conn, :show, komentar)
    assert html_response(conn, 200) =~ "Show komentar"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, komentar_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    komentar = Repo.insert! %Komentar{}
    conn = get conn, komentar_path(conn, :edit, komentar)
    assert html_response(conn, 200) =~ "Edit komentar"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    komentar = Repo.insert! %Komentar{}
    conn = put conn, komentar_path(conn, :update, komentar), komentar: @valid_attrs
    assert redirected_to(conn) == komentar_path(conn, :show, komentar)
    assert Repo.get_by(Komentar, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    komentar = Repo.insert! %Komentar{}
    conn = put conn, komentar_path(conn, :update, komentar), komentar: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit komentar"
  end

  test "deletes chosen resource", %{conn: conn} do
    komentar = Repo.insert! %Komentar{}
    conn = delete conn, komentar_path(conn, :delete, komentar)
    assert redirected_to(conn) == komentar_path(conn, :index)
    refute Repo.get(Komentar, komentar.id)
  end
end
