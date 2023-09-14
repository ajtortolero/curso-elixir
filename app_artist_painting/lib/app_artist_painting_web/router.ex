defmodule AppArtistPaintingWeb.Router do
  alias AppArtistPaintingWeb.ArtistaController
  alias AppArtistPaintingWeb.PinturaController
  use AppArtistPaintingWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    resources "/artistas", ArtistaController, except: [:new, :edit, :update]
    put "/artistas/:id", ArtistaController, :update

    resources "/pinturas", PinturaController, except: [:new, :edit, :update]
    put "/pinturas/:id", PinturaController, :update
  end
end
