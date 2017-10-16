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

  pipeline :identify do
    plug NovelWeb.Plug.IdentifyCurrentUser
  end

  pipeline :require_login do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :teacher do
    plug NovelWeb.Plug.AuthorizeTeacher
  end

  pipeline :course do
    plug NovelWeb.Plug.LoadCourse
  end

  pipeline :head do
    plug NovelWeb.Plug.AuthorizeHead
  end

  pipeline :student do
    plug NovelWeb.Plug.AuthorizeEnrollment
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :require_login, :identify]

    resources "/session", SessionController,
      only: [:delete], singleton: true
    resources "/profile", ProfileController,
      only: [:show], singleton: true

    scope "/teacher", Teacher, as: :teacher do
      pipe_through [:teacher]

      resources "/courses", CourseController, only: [:new, :create]
    end

    scope "/teacher", Teacher, as: :teacher do
      pipe_through [:teacher, :course, :head]

      resources "/courses", CourseController, except: [:index, :new, :create] do
        resources "/groups", GroupController
        resources "/labs", LabController
        resources "/enrollments", EnrollmentController,
          only: [:index, :show, :edit, :update]
      end
    end

    resources "/courses", CourseController, only: [] do
      pipe_through [:course]

      resources "/enrollment", EnrollmentController,
        only: [:new, :create, :show], singleton: true
    end

    scope "/student", Student, as: :student do
      pipe_through [:course, :student]

      resources "/courses", CourseController, only: [:show]
    end
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :require_login]

    resources "/profile", ProfileController,
      only: [:edit, :update], singleton: true
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :identify]

    resources "/", CourseController, only: [:index]
    resources "/courses", CourseController, only: [:show]
  end

  scope "/auth", NovelWeb do
    pipe_through [:browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
