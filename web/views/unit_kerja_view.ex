defmodule FotoKerja.UnitKerjaView do
  use FotoKerja.Web, :view

  def render("search.json", %{unit_kerja: datas}) do
    render_many(datas, FotoKerja.UnitKerjaView, "data.json", as: :data)
  end

  def render("data.json", %{data: data}) do
    data
  end
end

"""
defmodule FirstApp.HelloView do
  use FirstApp.Web, :view

  def render("apijson.json", %{pages: pages}) do
    %{data: render_many(pages, FirstApp.HelloView, "page.json", as: :page)}
  end

  def render("page.json", %{page: page}) do
    %{title: page.title}
  end
end

"""
