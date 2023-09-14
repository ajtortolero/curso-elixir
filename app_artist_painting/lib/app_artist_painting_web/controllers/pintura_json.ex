defmodule AppArtistPaintingWeb.PinturaJSON do
  alias AppArtistPainting.Pinturas.Pintura
  alias AppArtistPainting.Artistas.Artista

  @doc """
  Renders a list of pinturas.
  """
  def index(%{pinturas: pinturas}) do
    %{data: for(pintura <- pinturas, do: data(pintura))}
  end

  @doc """
  Renders a single pintura.
  """
  def show(%{pintura: pintura}) do
    %{data: data(pintura)}
  end

  defp data(%Pintura{} = pintura) do
    %{
      id: pintura.id,
      titulo: pintura.titulo,
      anio_creacion: pintura.anio_creacion,
      estilo_pintura: pintura.estilo_pintura,
      artista: data_artista(pintura.artista)
    }
  end

  defp data_artista(artista) when is_nil(artista), do: :ok

  defp data_artista(%Artista{} = artista) do
    %{
      id: artista.id,
      documento: artista.documento,
      nombre: artista.nombre,
      fecha_nacimiento: artista.fecha_nacimiento,
      nacionalidad: artista.nacionalidad,
      sexo: artista.sexo
    }
  end
end
