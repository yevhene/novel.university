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
    plug NovelWeb.Plug.CurrentUser
  end

  pipeline :require_identification do
    plug NovelWeb.Plug.EnsureCurrentUserIsIdentified
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :require_login, :require_identification]

    resources "/session", SessionController,
      only: [:delete], singleton: true
    resources "/profile", ProfileController,
      only: [:show], singleton: true
    resources "/courses", CourseController, except: [:index, :show] do
      resources "/groups", GroupController, except: [:show]
    end
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :require_login]

    resources "/profile", ProfileController,
      only: [:edit, :update], singleton: true
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :require_identification]

    resources "/", CourseController, only: [:index]
    resources "/courses", CourseController, only: [:show]
  end

  scope "/auth", NovelWeb do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
