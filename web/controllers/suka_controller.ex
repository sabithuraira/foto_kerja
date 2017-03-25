defmodule FotoKerja.SukaController do
  use FotoKerja.Web, :controller

  alias FotoKerja.Suka

  def create(conn, %{} = suka_params) do
    is_exist = Repo.get_by(Suka, foto_id: suka_params["foto_id"], user_id: suka_params["user_id"])
    case is_exist do
        nil ->
          changeset = Suka.changeset(%Suka{}, suka_params)

          case Repo.insert(changeset) do
              {:ok, suka} ->
                conn
                |> put_status(:created)
                |> render("suka.json", data: 1)
              {:error, changeset} ->
                conn
                |> put_status(:unprocessable_entity)
                |> render(FotoKerja.MessageView, "error.json", changeset: changeset)
            end
        _ -> 
          Repo.delete(is_exist)
          conn
          |> put_status(:created)
          |> render("suka.json", data: -1)
    end
  end
end
