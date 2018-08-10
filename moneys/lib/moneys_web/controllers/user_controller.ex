defmodule MoneysWeb.UserController do
  use MoneysWeb, :controller

  alias Moneys.{Repo, User}

  def index(conn, _params) do
    users = Repo.all(Moneys.User)
    render conn, users: users
  end

  def create(conn, params) do
    changeset = User.changeset(%User{}, params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        render conn, "show.json", user: user
      {:error, changeset} ->
        render conn, MoneysWeb.ChangesetView, "error.json", changeset: changeset
    end
  end

  def show(conn, params) do
    case Repo.get(User, params["id"]) do
      nil ->
        render conn, MoneysWeb.ErrorView, "404.json"
      user ->
        render conn, user: user
    end
  end

  def delete(conn, params) do
    case Repo.get(User, params["id"]) do
      nil ->
        render conn, MoneysWeb.ErrorView, "404.json"
      user ->
        render conn, user
    end
  end

  def actually_delete_user(user) do
    case Repo.delete(user) do
      {:ok, user} ->
        IO.inspect user
        "delete.json"
      {:error, changeset} ->
        {MoneysWeb.ChangesetView, "error.json", changeset: changeset}
    end
  end
end
