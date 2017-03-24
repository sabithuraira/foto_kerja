defmodule FotoKerja.FotoController do
  use FotoKerja.Web, :controller
  use Timex

  alias FotoKerja.Foto
  alias FotoKerja.UnitKerja
  alias FotoKerja.Kegiatan
  alias FotoKerja.Auth

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  defp list_uk do
    Repo.all(UnitKerja) |> Enum.map(&{&1.name, &1.id})
  end
  #list_uk=Repo.all(UnitKerja) |> Enum.map(&{&1.name, &1.id})

  defp list_kegiatan do
    Repo.all(Kegiatan) |> Enum.map(&{&1.name<>" | "<>Integer.to_string(&1.tahun), &1.id})
  end

  def index(conn, _params) do
    """
    foto = Repo.all(Foto)
    render(conn, "index.html", foto: foto)
    """

    query = 
      case Map.get(_params, "src_term") != nil do
        true -> 
              src_term=_params["src_term"]
              from u in Foto,
                    where:  ilike(u.description, ^"%#{src_term}%"),
                    order_by: [desc: :inserted_at],
                    select: u
        _ -> 
            from u in Foto,
                order_by: [desc: :inserted_at],
                select: u
      end

      datas = Repo.all(query)
                |> Repo.preload(:user)
                |> Repo.preload(:kegiatan)
                |> Repo.preload(:unit_kerja)
    
    render conn, "pages.json", datas: datas
  end

  def user(conn, _params) do
    cur_user = Auth.current_user(conn)
    render conn, "user.json", data: cur_user
  end

  def new(conn, _params) do
    changeset = Foto.changeset(%Foto{})

    render(conn, "new.html", changeset: changeset, 
      uk: list_uk,kegiatan: list_kegiatan)
  end
  
  def create(conn, %{"foto" => foto_params}) do
    cur_user = Auth.current_user(conn)
    changeset = Foto.changeset(%Foto{}, foto_params)

    if upload = foto_params["file_name"] do #and changeset.valid? do
      extension = Path.extname(upload.filename)
      temp_name=Enum.join([Timex.format!(Timex.now,"{ASN1:GeneralizedTime}"),cur_user.id],"")
  
      encrypt_name= Enum.join([temp_name,extension],"")

      #changeset = Foto.changeset(%Foto{}, foto_params)
      #  |> Ecto.Changeset.put_change(:file_name, encrypt_name)

      case Repo.insert(changeset
        |> Ecto.Changeset.put_change(:file_name, encrypt_name)
        |> Ecto.Changeset.put_change(:user_id, cur_user.id)
        ) do
        {:ok, _kegiatan} ->
          File.cp!(upload.path, "/Users/sabithuraira/Projects/Elixir/foto_kerja/media/#{encrypt_name}")
          conn
            |> put_flash(:info, "Wow, fotonya KEREN!! Upload lagi dong..")
            |> redirect(to: page_path(conn, :index))
        {:error, changeset} ->
          render(conn, "new.html", changeset: changeset, 
            uk: list_uk,kegiatan: list_kegiatan)
      end
    else
      render(conn, "new.html", changeset: changeset, 
        uk: list_uk,kegiatan: list_kegiatan)
    end
  end

  def show(conn, %{"id" => id}) do
    foto = Repo.get!(Foto, id)
    render(conn, "show.html", foto: foto)
  end

  def edit(conn, %{"id" => id}) do
    foto = Repo.get!(Foto, id)
    changeset = Foto.changeset(foto)
    render(conn, "edit.html", foto: foto, changeset: changeset)
  end

  def update(conn, %{"id" => id, "foto" => foto_params}) do
    foto = Repo.get!(Foto, id)
    changeset = Foto.changeset(foto, foto_params)

    case Repo.update(changeset) do
      {:ok, foto} ->
        conn
        |> put_flash(:info, "Foto updated successfully.")
        |> redirect(to: foto_path(conn, :show, foto))
      {:error, changeset} ->
        render(conn, "edit.html", foto: foto, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    foto = Repo.get!(Foto, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(foto)

    conn
    |> put_flash(:info, "Foto deleted successfully.")
    |> redirect(to: foto_path(conn, :index))
  end
end
