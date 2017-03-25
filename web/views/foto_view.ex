defmodule FotoKerja.FotoView do
  use FotoKerja.Web, :view
    
  def render("pages.json", %{datas: datas}) do
    %{data: render_many(datas, FotoKerja.FotoView, "page.json", as: :data)}
  end

  def render("page.json", %{data: data}) do
    %{
        id:             data.id,
        file_name:      data.file_name,
        description:    data.description,
        unit_kerja_id:  data.unit_kerja_id,
        kegiatan_id:    data.kegiatan_id,
        user_id:        data.user_id,
        inserted_at:    data.inserted_at,
        updated_at:     data.updated_at,
        user_name:      data.user.name,
        kegiatan:       data.kegiatan.name,
        unit_kerja:     data.unit_kerja.name,
        total_komentar: Enum.count(data.comments),
        total_suka:     Enum.count(data.suka),
    }
  end

  def render("user.json", %{data: data}) do
    data
  end
end
