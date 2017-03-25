defmodule FotoKerja.SukaView do
  use FotoKerja.Web, :view

  def render("suka.json", %{data: data}) do
    data
  end
end
