defmodule FotoKerja.FotoView do
  use FotoKerja.Web, :view
  alias FotoKerja.Repo
  alias FotoKerja.User
    
  def render("pages.json", %{datas: datas}) do
    %{data: render_many(datas, FotoKerja.FotoView, "page.json", as: :data)}
  end

  def render("page.json", %{data: data}) do
    
    lbl_like= case Enum.count(data.suka) > 0 do
          true ->  
            data.suka
              |> Stream.with_index 
              |> Enum.reduce("", fn({num, idx}, acc) ->
                  cond do
                    idx==0 ->
                      suka_user = Repo.get(User, num.user_id)
                      if Enum.count(data.suka) ==1 do
                        acc <> suka_user.name <> " menyukai foto ini"
                      else
                        acc <> suka_user.name
                      end
                    idx==1 -> 
                      suka_user = Repo.get(User, num.user_id)
                      if Enum.count(data.suka) == 2 do
                        acc <> " dan "  <> suka_user.name <> " menyukai foto ini"
                      else
                        acc <> " , "  <> suka_user.name
                      end
                    true ->
                      remains = Enum.count(data.suka) - 2
                      acc <> " dan " <> Integer.to_string(remains) <> " orang lainnya menyukai foto ini"
                  end
                end)
            
          _ -> "Belum ada yang menyukai foto ini"
        end
    %{
        id:             data.id,
        file_name:      data.file_name,
        description:    data.description,
        #unit_kerja_id:  data.unit_kerja_id,
        #kegiatan_id:    data.kegiatan_id,
        user_id:        data.user_id,
        inserted_at:    Timex.from_now(data.inserted_at),
        updated_at:     data.updated_at,
        user_name:      data.user.name,
        kegiatan:       data.kegiatan.name,
        unit_kerja:     data.unit_kerja.name,
        total_komentar: Enum.count(data.comments),
        total_suka:     Enum.count(data.suka),
        label_like:     lbl_like,
    }
  end

  def render("user.json", %{data: data}) do
    data
  end
end
