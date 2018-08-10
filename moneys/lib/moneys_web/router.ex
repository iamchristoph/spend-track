defmodule MoneysWeb.Router do
  use MoneysWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MoneysWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", MoneysWeb do
    pipe_through :api
    resources "/users", UserController, only: [:index, :create, :delete, :show]
  end
end
