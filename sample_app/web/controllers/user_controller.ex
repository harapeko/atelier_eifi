defmodule SampleApp.UserController do
  use SampleApp.Web, :controller

  def new(conn, _params) do
    render(conn, "new.html", changeset: SampleApp.User.new)
  end

  def show(conn, %{"id" => id}) do
    # DBからユーザIDで検索してビューに渡している
    user = Repo.get(SampleApp.User, id)
    render(conn, "show.html", user: user)
  end
end