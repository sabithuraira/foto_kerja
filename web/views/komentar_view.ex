defmodule FotoKerja.KomentarView do
  use FotoKerja.Web, :view

  def render("pages.json", %{datas: datas}) do
    %{data: render_many(datas, FotoKerja.KomentarView, "page.json", as: :data)}
  end

  def render("page.json", %{data: data}) do
    %{
        id:             data.id,
        description:    data.description,
        foto_id:        data.foto_id,
        user_id:        data.user_id,
        inserted_at:    data.inserted_at,
        updated_at:     data.updated_at,
        user_name:      data.user_id
    }
  end
end
