defmodule AppArtistPaintingWeb.ArtistaController do
  use AppArtistPaintingWeb, :controller

  alias AppArtistPainting.Artistas
  alias AppArtistPainting.Artistas.Artista

  action_fallback AppArtistPaintingWeb.FallbackController

  def index(conn, _params) do
    artistas = Artistas.list_artistas()
    render(conn, :index, artistas: artistas)
  end

  def create(conn, %{"artista" => artista_params}) do
    with {:ok, %Artista{} = artista} <- Artistas.create_artista(artista_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/artistas/#{artista}")
      |> render(:show, artista: artista)
    end
  end

  def show(conn, %{"id" => id}) do
    artista = Artistas.get_artista!(id)
    render(conn, :show, artista: artista)
  end

  def update(conn, %{"id" => id, "artista" => artista_params}) do
    artista = Artistas.get_artista!(id)

    with {:ok, %Artista{} = artista} <- Artistas.update_artista(artista, artista_params) do
      render(conn, :show, artista: artista)
    end
  end

  def delete(conn, %{"id" => id}) do
    artista = Artistas.get_artista!(id)

    with {:ok, %Artista{}} <- Artistas.delete_artista(artista) do
      send_resp(conn, :no_content, "")
    end
  end
end
