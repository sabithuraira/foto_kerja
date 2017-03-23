defmodule FotoKerja.KegiatanController do
  use FotoKerja.Web, :controller

  alias FotoKerja.Kegiatan
  alias FotoKerja.Auth

  def index(conn, _params) do
    kegiatan = Repo.all(Kegiatan)
    render(conn, "index.html", kegiatan: kegiatan)
  end

  def new(conn, _params) do
    changeset = Kegiatan.changeset(%Kegiatan{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"kegiatan" => kegiatan_params}) do
    cur_user = Auth.current_user(conn)
    changeset = Kegiatan.changeset(%Kegiatan{user_id: cur_user.id}, kegiatan_params)

    case Repo.insert(changeset) do
      {:ok, _kegiatan} ->
        conn
        |> put_flash(:info, "Kegiatan created successfully.")
        |> redirect(to: kegiatan_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    kegiatan = Repo.get!(Kegiatan, id)
    render(conn, "show.html", kegiatan: kegiatan)
  end

  def edit(conn, %{"id" => id}) do
    kegiatan = Repo.get!(Kegiatan, id)
    changeset = Kegiatan.changeset(kegiatan)
    render(conn, "edit.html", kegiatan: kegiatan, changeset: changeset)
  end

  def update(conn, %{"id" => id, "kegiatan" => kegiatan_params}) do
    kegiatan = Repo.get!(Kegiatan, id)
    changeset = Kegiatan.changeset(kegiatan, kegiatan_params)

    case Repo.update(changeset) do
      {:ok, kegiatan} ->
        conn
        |> put_flash(:info, "Kegiatan updated successfully.")
        |> redirect(to: kegiatan_path(conn, :show, kegiatan))
      {:error, changeset} ->
        render(conn, "edit.html", kegiatan: kegiatan, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    kegiatan = Repo.get!(Kegiatan, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(kegiatan)

    conn
    |> put_flash(:info, "Kegiatan deleted successfully.")
    |> redirect(to: kegiatan_path(conn, :index))
  end
end
