defmodule MoneysWeb.UserView do
  use MoneysWeb, :view

  def render("index.json", %{users: users}) do
    render_many(users, MoneysWeb.UserView, "show.json")
  end

  def render("show.json", %{user: user}) do
    %{
      name: user.name,
      id: user.id
    }
  end

  def render("delete.json", _) do
    %{ok: true}
  end
end
