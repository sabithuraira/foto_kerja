defmodule FotoKerja.UnitKerjaController do
  use FotoKerja.Web, :controller

  alias FotoKerja.UnitKerja
  alias FotoKerja.Auth

  def index(conn, _params) do
    unit_kerja = Repo.all(UnitKerja)
    render(conn, "index.html", unit_kerja: unit_kerja)
  end

  def search(conn, %{"id" => id}) do
    text_filter=id

    query = 
      case text_filter do
        "-" -> from u in UnitKerja,
                select: u
        _ -> from u in UnitKerja,
              where:  ilike(u.name, ^"%#{text_filter}%"),
              select: u
      end

    unit_kerja = Repo.all(query)
    render(conn, "search.json", unit_kerja: unit_kerja) 
  end

  def new(conn, _params) do
    changeset = UnitKerja.changeset(%UnitKerja{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"unit_kerja" => unit_kerja_params}) do
    cur_user = Auth.current_user(conn)
    changeset = UnitKerja.changeset(%UnitKerja{user_id: cur_user.id}, unit_kerja_params)

    case Repo.insert(changeset) do
      {:ok, _unit_kerja} ->
        conn
        |> put_flash(:info, "Unit kerja created successfully.")
        |> redirect(to: unit_kerja_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    unit_kerja = Repo.get!(UnitKerja, id)
    render(conn, "show.html", unit_kerja: unit_kerja)
  end

  def edit(conn, %{"id" => id}) do
    unit_kerja = Repo.get!(UnitKerja, id)
    changeset = UnitKerja.changeset(unit_kerja)
    render(conn, "edit.html", unit_kerja: unit_kerja, changeset: changeset)
  end

  def update(conn, %{"id" => id, "unit_kerja" => unit_kerja_params}) do
    unit_kerja = Repo.get!(UnitKerja, id)
    changeset = UnitKerja.changeset(unit_kerja, unit_kerja_params)

    case Repo.update(changeset) do
      {:ok, unit_kerja} ->
        conn
        |> put_flash(:info, "Unit kerja updated successfully.")
        |> redirect(to: unit_kerja_path(conn, :show, unit_kerja))
      {:error, changeset} ->
        render(conn, "edit.html", unit_kerja: unit_kerja, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    unit_kerja = Repo.get!(UnitKerja, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(unit_kerja)

    conn
    |> put_flash(:info, "Unit kerja deleted successfully.")
    |> redirect(to: unit_kerja_path(conn, :index))
  end
end
