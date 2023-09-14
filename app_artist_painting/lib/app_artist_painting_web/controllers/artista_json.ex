defmodule AppArtistPaintingWeb.ArtistaJSON do
  alias AppArtistPainting.Artistas.Artista
  alias AppArtistPainting.Pinturas.Pintura

  @doc """
  Renders a list of artistas.
  """
  def index(%{artistas: artistas}) do
    %{data: for(artista <- artistas, do: data(artista))}
  end

  @doc """
  Renders a single artista.
  """
  def show(%{artista: artista}) do
    %{data: data(artista)}
  end

  defp data(%Artista{} = artista) do
    %{
      id: artista.id,
      documento: artista.documento,
      nombre: artista.nombre,
      fecha_nacimiento: artista.fecha_nacimiento,
      nacionalidad: artista.nacionalidad,
      sexo: artista.sexo,
      pinturas: for(v <- artista.pinturas, do: data_pinturas(v))
    }
  end

  defp data_pinturas(%Pintura{} = pintura) do
    %{
      id: pintura.id,
      titulo: pintura.titulo,
      anio_creacion: pintura.anio_creacion,
      estilo_pintura: pintura.estilo_pintura
    }
  end
end
