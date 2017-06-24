defmodule FotoKerja.AuthController do
  use FotoKerja.Web, :controller
  plug Ueberauth
  
  def login(conn, _params) do
    render conn, "login.html"
  end

  def authenticate(conn, %{"user" => user_params}) do
    case FotoKerja.Auth.login(user_params, FotoKerja.Repo) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        #|> put_session(:current_user, user.id)
        |> put_flash(:info, "Berhasil Login. Bagikan momen menarik pekerjaan anda! Masukkan foto anda pada FotoKerja")
        |> redirect(to: "/")
      :error ->
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("login.html")
    end
  end

  def logout(conn, _) do
    Guardian.Plug.sign_out(conn)
      #|> delete_session(:current_user)
      |> put_flash(:info, "Logged out")
      |> redirect(to: "/")
  end

  # def request(conn, _params) do
  #   render(conn, "request.html", callback_url: Helpers.callback_url(conn))
  # end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case FotoKerja.Auth.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated.")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end
end
