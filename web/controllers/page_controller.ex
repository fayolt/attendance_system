defmodule AttendanceSystem.PageController do
  use AttendanceSystem.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
