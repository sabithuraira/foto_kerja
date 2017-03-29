defmodule FotoKerja.SukaController do
  use FotoKerja.Web, :controller

  alias FotoKerja.Suka


    require Logger

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
 
  def show(conn, %{"id" => id}) do
    query = from u in Suka,
                where:  u.foto_id==^id,
                order_by: [asc: :inserted_at],
                select: u

    datas = Repo.all(query)
                |> Repo.preload(:user)
      

    lbl_comment= case Enum.count(datas) > 0 do
          true ->  
            datas
              |> Stream.with_index 
              |> Enum.reduce("", fn({num, idx}, acc) ->
                  cond do
                    idx==0 ->
                      if Enum.count(datas) ==1 do
                        acc <> num.user.name <> " menyukai foto ini"
                      else
                        acc <> num.user.name
                      end
                    idx==1 -> 
                      if Enum.count(datas) == 2 do
                        acc <> " dan "  <> num.user.name <> " menyukai foto ini"
                      else
                        acc <> " , "  <> num.user.name
                      end
                    true ->
                      remains = Enum.count(datas) - 2
                      acc <> " dan " <> Integer.to_string(remains) <> " orang lainnya menyukai foto ini"
                  end
                end)
            
          _ -> "Belum ada yang menyukai foto ini"
        end
    
    render conn, "suka.json", data: lbl_comment
  end
end
