defmodule NovelWeb.Router do
  use NovelWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :guardian do
    plug Ueberauth
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
    plug NovelWeb.Plug.LoadCourseCounters
  end

  pipeline :head do
    plug NovelWeb.Plug.AuthorizeHead
  end

  pipeline :student do
    plug NovelWeb.Plug.LoadEnrollment
    plug NovelWeb.Plug.AuthorizeEnrollment
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :guardian, :require_login, :identify]

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
        resources "/enrollments", EnrollmentController,
          only: [:index, :show, :edit, :update]
        resources "/labs", LabController
        resources "/submissions", SubmissionController,
          only: [:index, :show, :edit, :update]
        resources "/quizzes", QuizController do
          resources "/questions", QuestionController, except: [:index]
        end
      end
    end

    resources "/courses", CourseController, only: [] do
      pipe_through [:course]

      resources "/enrollment", EnrollmentController,
        only: [:new, :create], singleton: true
    end

    scope "/student", Student, as: :student do
      pipe_through [:course, :student]

      resources "/courses", CourseController, only: [:show] do
        resources "/labs", LabController, only: [:index, :show] do
          resources "/submissions", SubmissionController, only: [:new, :create]
        end
      end
    end
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :guardian, :require_login]

    resources "/profile", ProfileController,
      only: [:edit, :update], singleton: true

    resources "/repositories", RepositoryController, only: [:index]
  end

  scope "/", NovelWeb do
    pipe_through [:browser, :guardian, :identify]

    resources "/", CourseController, only: [:index]
    resources "/courses", CourseController, only: [:show]
  end

  scope "/auth", NovelWeb do
    pipe_through [:browser, :guardian]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
end
