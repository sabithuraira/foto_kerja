defmodule FotoKerja.SukaControllerTest do
  use FotoKerja.ConnCase

  alias FotoKerja.Suka
  @valid_attrs %{is_suka: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, suka_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing suka"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, suka_path(conn, :new)
    assert html_response(conn, 200) =~ "New suka"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, suka_path(conn, :create), suka: @valid_attrs
    assert redirected_to(conn) == suka_path(conn, :index)
    assert Repo.get_by(Suka, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, suka_path(conn, :create), suka: @invalid_attrs
    assert html_response(conn, 200) =~ "New suka"
  end

  test "shows chosen resource", %{conn: conn} do
    suka = Repo.insert! %Suka{}
    conn = get conn, suka_path(conn, :show, suka)
    assert html_response(conn, 200) =~ "Show suka"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, suka_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    suka = Repo.insert! %Suka{}
    conn = get conn, suka_path(conn, :edit, suka)
    assert html_response(conn, 200) =~ "Edit suka"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    suka = Repo.insert! %Suka{}
    conn = put conn, suka_path(conn, :update, suka), suka: @valid_attrs
    assert redirected_to(conn) == suka_path(conn, :show, suka)
    assert Repo.get_by(Suka, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    suka = Repo.insert! %Suka{}
    conn = put conn, suka_path(conn, :update, suka), suka: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit suka"
  end

  test "deletes chosen resource", %{conn: conn} do
    suka = Repo.insert! %Suka{}
    conn = delete conn, suka_path(conn, :delete, suka)
    assert redirected_to(conn) == suka_path(conn, :index)
    refute Repo.get(Suka, suka.id)
  end
end
