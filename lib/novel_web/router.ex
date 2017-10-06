defmodule NovelWeb.Router do
  use NovelWeb, :router

  pipeline :browser do
    plug Ueberauth

    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug Guardian.Plug.Pipeline,
      module: NovelWeb.Guardian,
      error_handler: NovelWeb.Guardian.ErrorHandler
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", NovelWeb do
    pipe_through [:browser]

    get "/", PageController, :index
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :auth]

    resources "/session", SessionController, only: [:delete], singleton: true
  end

  scope "/auth", NovelWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
