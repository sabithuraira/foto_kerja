defmodule FotoKerja.SukaController do
  use FotoKerja.Web, :controller

  alias FotoKerja.Suka

  def index(conn, _params) do
    suka = Repo.all(Suka)
    render(conn, "index.html", suka: suka)
  end

  def new(conn, _params) do
    changeset = Suka.changeset(%Suka{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"suka" => suka_params}) do
    changeset = Suka.changeset(%Suka{}, suka_params)

    case Repo.insert(changeset) do
      {:ok, _suka} ->
        conn
        |> put_flash(:info, "Suka created successfully.")
        |> redirect(to: suka_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    suka = Repo.get!(Suka, id)
    render(conn, "show.html", suka: suka)
  end

  def edit(conn, %{"id" => id}) do
    suka = Repo.get!(Suka, id)
    changeset = Suka.changeset(suka)
    render(conn, "edit.html", suka: suka, changeset: changeset)
  end

  def update(conn, %{"id" => id, "suka" => suka_params}) do
    suka = Repo.get!(Suka, id)
    changeset = Suka.changeset(suka, suka_params)

    case Repo.update(changeset) do
      {:ok, suka} ->
        conn
        |> put_flash(:info, "Suka updated successfully.")
        |> redirect(to: suka_path(conn, :show, suka))
      {:error, changeset} ->
        render(conn, "edit.html", suka: suka, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    suka = Repo.get!(Suka, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(suka)

    conn
    |> put_flash(:info, "Suka deleted successfully.")
    |> redirect(to: suka_path(conn, :index))
  end
end
