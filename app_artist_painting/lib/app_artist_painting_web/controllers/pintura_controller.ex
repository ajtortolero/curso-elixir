defmodule AppArtistPaintingWeb.PinturaController do
  use AppArtistPaintingWeb, :controller

  alias AppArtistPainting.Pinturas
  alias AppArtistPainting.Pinturas.Pintura

  action_fallback AppArtistPaintingWeb.FallbackController

  def index(conn, _params) do
    pinturas = Pinturas.list_pinturas()
    render(conn, :index, pinturas: pinturas)
  end

  def create(conn, %{"pintura" => pintura_params}) do
    with {:ok, %Pintura{} = pintura} <- Pinturas.create_pintura(pintura_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/pinturas/#{pintura}")
      |> render(:show, pintura: pintura)
    end
  end

  def show(conn, %{"id" => id}) do
    pintura = Pinturas.get_pintura!(id)
    render(conn, :show, pintura: pintura)
  end

  def update(conn, %{"id" => id, "pintura" => pintura_params}) do
    pintura = Pinturas.get_pintura!(id)

    with {:ok, %Pintura{} = pintura} <- Pinturas.update_pintura(pintura, pintura_params) do
      render(conn, :show, pintura: pintura)
    end
  end

  def delete(conn, %{"id" => id}) do
    pintura = Pinturas.get_pintura!(id)

    with {:ok, %Pintura{}} <- Pinturas.delete_pintura(pintura) do
      send_resp(conn, :no_content, "")
    end
  end
end
