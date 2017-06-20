defmodule FotoKerja.Auth do
   alias FotoKerja.User

  def login(params, repo) do
    user = repo.get_by(User, username: String.downcase(params["username"]))
    case authenticate(user, params["password"]) do
      true -> {:ok, user}
      _    -> :error
    end
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.password)
    end
  end

  def current_user(conn) do
    user =  Guardian.Plug.current_resource(conn) #Plug.Conn.get_session(conn, :current_user)
    if user, do: FotoKerja.Repo.get(User, user.id)
  end

  def logged_in?(conn), do: !!current_user(conn)

  """
  def action_by_login(conn, default) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id do
      assign(conn, :current_user, current_user)
    else
      conn
        |> put_flash(:error, 'You need to be signed in to view this page')
        |> redirect(to: session_path(conn, :new))
    end
  end
  """
end
