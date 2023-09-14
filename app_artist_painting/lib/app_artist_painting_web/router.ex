defmodule AppArtistPaintingWeb.Router do
  use AppArtistPaintingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AppArtistPaintingWeb do
    pipe_through :api
  end
end
