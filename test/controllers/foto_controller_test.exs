defmodule FotoKerja.FotoControllerTest do
  use FotoKerja.ConnCase

  alias FotoKerja.Foto
  @valid_attrs %{description: "some content", file_name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, foto_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing foto"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, foto_path(conn, :new)
    assert html_response(conn, 200) =~ "New foto"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, foto_path(conn, :create), foto: @valid_attrs
    assert redirected_to(conn) == foto_path(conn, :index)
    assert Repo.get_by(Foto, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, foto_path(conn, :create), foto: @invalid_attrs
    assert html_response(conn, 200) =~ "New foto"
  end

  test "shows chosen resource", %{conn: conn} do
    foto = Repo.insert! %Foto{}
    conn = get conn, foto_path(conn, :show, foto)
    assert html_response(conn, 200) =~ "Show foto"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, foto_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    foto = Repo.insert! %Foto{}
    conn = get conn, foto_path(conn, :edit, foto)
    assert html_response(conn, 200) =~ "Edit foto"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    foto = Repo.insert! %Foto{}
    conn = put conn, foto_path(conn, :update, foto), foto: @valid_attrs
    assert redirected_to(conn) == foto_path(conn, :show, foto)
    assert Repo.get_by(Foto, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    foto = Repo.insert! %Foto{}
    conn = put conn, foto_path(conn, :update, foto), foto: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit foto"
  end

  test "deletes chosen resource", %{conn: conn} do
    foto = Repo.insert! %Foto{}
    conn = delete conn, foto_path(conn, :delete, foto)
    assert redirected_to(conn) == foto_path(conn, :index)
    refute Repo.get(Foto, foto.id)
  end
end
