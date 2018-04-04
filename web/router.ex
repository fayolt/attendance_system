defmodule AttendanceSystem.Router do
  use AttendanceSystem.Web, :router

  def guardian_current_user(conn, _) do
    Plug.Conn.assign(conn, :current_user, Guardian.Plug.current_resource(conn))
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", AttendanceSystem do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  pipeline :auth_api do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: AttendanceSystem.SessionApiController  
    plug :guardian_current_user
  end

  scope "/api", AttendanceSystem do
    pipe_through :api
    post "/users", UserApiController, :create
    post "/sessions", SessionApiController, :create
  end

  scope "/api", AttendanceSystem do
    pipe_through [:api, :auth_api]
    delete "/sessions/:id", SessionApiController, :delete
    resources "/users", UserApiController, only: [:update, :show, :delete, :index]
  end
end
