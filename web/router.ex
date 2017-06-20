defmodule FotoKerja.Router do
  use FotoKerja.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end


  scope "/", FotoKerja do
    pipe_through [:browser, :browser_session] # Use the default browser stack

    get "/", PageController, :index
    get "/test", PageController, :test
    resources "/users", UserController
    resources "/kegiatan", KegiatanController
    resources "/unitkerja", UnitKerjaController
    get "/unitkerja/search/:id", UnitKerjaController , :search
    get "/foto/user", FotoController, :user
    resources "/foto", FotoController
    resources "/komentar", KomentarController, except: [:index]
    get "/komentar/foto/:id", KomentarController , :index
    resources "/suka", SukaController
    get "/login", AuthController, :login
    post "/login", AuthController, :authenticate
    delete "/logout", AuthController, :logout
  end

  scope "/auth", FotoKerja do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  """
  scope "/api", TodoApi do
    pipe_through :api

    resources "/foto", FotoController, only: [:index]
    get "/komentar/foto/:id", KomentarController , :index
  end
  """
  

  # Other scopes may use custom stacks.
  # scope "/api", FotoKerja do
  #   pipe_through :api
  # end
end
