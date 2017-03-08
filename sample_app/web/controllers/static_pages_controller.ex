defmodule SampleApp.StaticPagesController do
  use SampleApp.Web, :controller
  
  # home
  # Q: connってなんぞ？
  # Q: _paramsも何がはいるんです？
  def home(conn, _params) do
    render conn, "home.html"
  end
  
  def help(conn, _params) do
    render conn, "help.html"
  end
end