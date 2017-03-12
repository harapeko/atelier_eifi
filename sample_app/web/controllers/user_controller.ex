defmodule SampleApp.UserController do
  use SampleApp.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(SampleApp.User, id)
    render(conn, "show.html", user: user)
  end
end