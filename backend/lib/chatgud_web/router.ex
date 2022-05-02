defmodule ChatgudWeb.Router do
  use ChatgudWeb, :router

  alias ChatgudWeb.Plugs

  @graphql_endpoint "/api/graphql"

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug(Plugs.AuthContext)
  end

  scope @graphql_endpoint do
    pipe_through :graphql

    forward "/", Absinthe.Plug, schema: ChatgudWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ChatgudWeb.Telemetry
    end

    scope "/" do
      pipe_through :api

      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: ChatgudWeb.Schema,
        interface: :playground,
        context: %{pubsub: ChatgudWeb.Endpoint},
        default_url: @graphql_endpoint,
        socket: ChatgudWeb.UserSocket
    end
  end
end
