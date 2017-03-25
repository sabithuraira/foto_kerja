defmodule FotoKerja.AuthController do
  use FotoKerja.Web, :controller
  
  def login(conn, _params) do
    render conn, "login.html"
  end

  def authenticate(conn, %{"user" => user_params}) do
    case FotoKerja.Auth.login(user_params, FotoKerja.Repo) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user.id)
        #|> put_flash(:info, "Berhasil Log in")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("login.html")
    end
  end

  def logout(conn, _) do
    conn
      |> delete_session(:current_user)
      |> put_flash(:info, "Logged out")
      |> redirect(to: "/")
  end
end
