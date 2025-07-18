defmodule BiltonglyWeb.Router do
  use BiltonglyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BiltonglyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BiltonglyWeb do
    pipe_through :browser

    # get "/", PageController, :home
    live "/", BoxLive.Index, :index
    live "/about", BoxLive.About, :about
    live "/water-timer", WaterTimerLive.Index, :index
    # live "/boxes/new", BoxLive.Index, :new
    # live "/boxes/:id/edit", BoxLive.Index, :edit

    # live "/boxes/:id", BoxLive.Show, :show
    # live "/boxes/:id/show/edit", BoxLive.Show, :edit
    # 
    # ecommerce time!
    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit

    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit

    live "/cart", CartLive.Index, :index
    live "/cart/new", CartLive.Index, :new
    live "/cart/:id/edit", CartLive.Index, :edit

    live "/cart/:id", CartLive.Show, :show
    live "/cart/:id/show/edit", CartLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BiltonglyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:biltongly, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BiltonglyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  # Add the BiltonglyWeb namespace here
  scope "/api", BiltonglyWeb do
    pipe_through :api

    post "/soil_readings", SoilReadingController, :create
  end
end
