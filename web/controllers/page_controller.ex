defmodule FotoKerja.PageController do
  use FotoKerja.Web, :controller
    
  require Logger

  def index(conn, _params) do
    Logger.info System.get_env("FACEBOOK_CLIENT_ID")
    render conn, "index.html"
  end

  def test(conn, _params) do
    render conn, "test.html"
  end
end
